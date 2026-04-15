# Day 35 – Multi-Stage Builds & Docker Hub

---

# Task 1: Single-Stage Build (Inefficient Image)

### 1. Simple App 

### 2. Single-stage Dockerfile

### 3. Build the image

```bash
docker build -t single-stage-demo .
```

### 4. Check size

```bash
docker images
```

 Typical size:

* `node:20` base image ≈ **900MB+**
* Final image ≈ **900MB–1GB**

---

#  Problem

You're shipping:

* Full Node runtime
* Build tools
* OS packages you don’t need

This is operationally expensive (bandwidth, storage, cold start latency).

---

## Task 2: Multi-Stage Build (Optimized)

### 1. Multi-stage Dockerfile


### 2. Build optimized image

```bash
docker build -t multi-stage-demo .
```

### 3. Check size again

```bash
docker images
```

 Typical result:

* `node:20-alpine` ≈ **50–70MB**
* Final image ≈ **~60MB**

---

### Comparison

| Build Type   | Size   |
| ------------ | ------ |
| Single-stage | ~900MB |
| Multi-stage  | ~60MB  |

---

### Why Multi-Stage is Smaller

Because it **eliminates build-time artifacts and unnecessary layers**:

* Only final runtime files are copied
* No compilers / package managers in final image
* Alpine base is drastically smaller than Debian-based Node
* Reduces attack surface and CVE exposure

---

## Task 3: Push to Docker Hub

### 1. Login

```bash
docker login
```

### 2. Tag image

```bash
docker tag multi-stage-demo yourusername/node-demo:v1
```
- Example
```bash
docker tag multi-stage-demo sumit9165/node-demo:v1
```

### 3. Push

```bash
docker push yourusername/node-demo:v1
```
```bash
docker push sumit9165/node-demo:v1
```

### 4. Verify pull

```bash
docker pull yourusername/node-demo:v1
```
```bash
docker pull sumit9165/node-demo:v1
```
(Test)

```bash
docker run -d -p 80:3000 yourusername/node-demo:v1
```
```bash
docker run -d -p 80:3000 sumit9165/node-demo:v1
```
---

## Task 4: Docker Hub Exploration

### Key Observations

**Tags tab:**

* `latest` → default if no tag specified
* `v1`, `v2`, etc → versioned releases

### Behavior

```bash
docker pull yourusername/node-demo
```

➡ pulls `latest`

```bash
docker pull yourusername/node-demo:v1
```

➡ pulls that exact immutable version

### Best practice:

* Never rely on `latest` in production
* Always pin versions

---

## Task 5: Best Practices Applied

### Improved Dockerfile

```Dockerfile
FROM node:20-alpine

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY app.js .

USER appuser

CMD ["node", "app.js"]
```

---

### Improvements Explained

| Practice                        | Effect                  |
| ------------------------------- | ----------------------- |
| Alpine base                     | Smaller footprint       |
| Non-root USER                   | Better security         |
| No unnecessary layers           | Smaller + cleaner image |
| Specific tag (`node:20-alpine`) | Reproducibility         |

---

### Expected Final Size

~50–60MB

---

### Key Takeaways

* Image size is dominated by the **base image**
* Multi-stage builds = **separation of concerns**
* Smaller images = faster deploys + lower cost + better security
* Docker Hub tags are effectively **version control for images**

---

