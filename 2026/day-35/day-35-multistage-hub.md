# Day 35 – Multi-Stage Builds & Docker Hub

Aaj ke din hum seekhenge ki production-ready Docker images kaise banate hain - chhote, secure, aur sharing ke liye. Multi-stage builds aur Docker Hub dono interview mein bahut puchhte hain.

---

## Task 1: The Problem with Large Images

Jab hum normally Dockerfile likhte hain, toh bahut saare unnecessary files image mein aa jate hain. Result - bada image, slow deployments, security risks.

### Example - Simple Node.js App

Mere paas ek simple Node.js app hai:
```javascript
// index.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello Docker!');
});

app.listen(3000, () => {
  console.log('Server chal raha hai!');
});
```

### package.json
```json
{
  "name": "myapp",
  "version": "1.0.0",
  "main": "index.js",
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {}
}
```

### Single Stage Dockerfile (Problem Wala)
```dockerfile
FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```

### Build and Check Size:
```bash
docker build -t myapp-single .
docker images myapp-single
```

**Result:** Image size approx **1GB+** (node:18 image bada hai!)

### Problem:
- Poora Node.js runtime aata hai
- Dev dependencies bhi included
- Compilation tools jo production mein chahiye nahi
- Security vulnerabilities zyada

---

## Task 2: Multi-Stage Build (Solution)

Multi-stage build mein hum do alag stages use karte hain:

### Stage 1: Build (Builder)
- Dependencies install karo
- App build karo
- Compilation karo

### Stage 2: Production
- Sirf final output copy karo
- Chhota base image use karo (alpine ya slim)

### Multi-Stage Dockerfile:
```dockerfile
# Stage 1: Build Stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build  # Agar build step chahiye

# Stage 2: Production Stage
FROM node:18-alpine

WORKDIR /app

# Sirf production dependencies
COPY package*.json ./
RUN npm install --production

# Builder se sirf files copy karo
COPY --from=builder /app .

EXPOSE 3000

USER node

CMD ["node", "index.js"]
```

### Build and Check:
```bash
docker build -t myapp-multistage .
docker images myapp-multistage
```

### Compare Results:

| Image Type | Size |
|------------|------|
| Single Stage (node:18) | ~1GB |
| Multi-Stage (node:18-alpine) | ~170MB |
| Multi-Stage with alpine | ~150MB |

### Why So Much Smaller?

1. **Alpine base** - 5MB ka base vs 900MB+
2. **Production only** - dev dependencies nahi
3. **Only artifact** - sirf compiled code, naki source + build tools
4. **Fewer layers** - optimized Dockerfile

---

## Task 3: Push to Docker Hub

Ab image ko publicly share karne ke liye Docker Hub par push karte hain.

### Step 1: Docker Hub Account Banayein
1. [hub.docker.com](https://hub.docker.com) jayein
2. Free account create karo
3. Username note karo (e.g., `myusername`)

### Step 2: Terminal se Login
```bash
docker login

# Output:
# Username: myusername
# Password: ********
# Login Succeeded
```

### Step 3: Image Tag Karein
```bash
# Format: username/repository:tag
docker tag myapp-multistage myusername/myapp:latest
```

### Step 4: Push Karein
```bash
docker push myusername/myapp:latest
```

### Step 5: Verify - Pull from Anywhere
```bash
# Local se hata kar do
docker rmi myusername/myapp:latest

# Hub se pull karo
docker pull myusername/myapp:latest

# Run karo
docker run -p 3000:3000 myusername/myapp:latest
```

---

## Task 4: Docker Hub Repository Explore Karein

Docker Hub website par jakar:

1. **Repository dekho** - Tera image dikhega
2. **Description add karo** - "My Node.js app"
3. **Tags tab** dekho:
   - `latest` - sabse latest version
   - `v1.0`, `v1.1` - version numbers
   - `latest` pull karne se latest milta hai
   - Specific tag like `v1.0` se exact version milta hai

### Tags ka Fayda:
```bash
# Latest
docker pull myusername/myapp:latest

# Specific version
docker pull myusername/myapp:v1.0
```

---

## Task 5: Image Best Practices

Ab apne image ko aur behtar banayenge:

### 1. Minimal Base Image
```dockerfile
# Bad - bada image
FROM node:18

# Good - chhota image
FROM node:18-alpine
```

### 2. Don't Run as Root
```dockerfile
FROM node:18-alpine

RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser

USER appuser
```

### 3. Combine RUN Commands (Reduce Layers)
```dockerfile
# Bad - alag-alag layers
RUN apt-get update
RUN apt-get install -y git
RUN apt-get clean

# Good - ek hi command
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### 4. Specific Tags (Not Latest)
```dockerfile
# Bad
FROM node:latest

# Good
FROM node:18-alpine
```

### Complete Optimized Dockerfile:
```dockerfile
# Build Stage
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# Production Stage
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY --from=builder /app .

USER node

EXPOSE 3000

CMD ["node", "index.js"]
```

### Check Size Difference:
```bash
# Before: ~1GB
# After optimization: ~150MB
```

---

## Summary

### Multi-Stage Build Key Points:
1. **FROM ... AS builder** - Build stage define karein
2. **COPY --from=builder** - Sirf compiled files copy karo
3. **Alpine base** - Use karo for small size

### Docker Hub Key Points:
1. **docker login** - Terminal se login
2. **docker tag** - Proper format mein tag karo
3. **docker push** - Hub par bhejo
4. **docker pull** - Kahi se bhi download karo

### Image Optimization:
- Alpine base use karo
- Root user se bachho
- Layers combine karo
- Specific tags use karo
- Multi-stage se image chhota karo

### Key Commands:
```bash
# Build
docker build -t myapp .

# Tag for Hub
docker tag myapp myusername/myapp:v1.0

# Push
docker push myusername/myapp:v1.0

# Pull
docker pull myusername/myapp:v1.0

# Check size
docker images
```