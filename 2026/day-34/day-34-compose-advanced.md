# 🚀 Day 34 – Docker Compose: Real-World Multi-Container Apps

## 📌 Project Used

EasyShop (Next.js + MongoDB + Redis)

---

# 🧱 Architecture

This project uses a **3-service architecture**:

* **Web App** → Next.js application
* **Database** → MongoDB
* **Cache** → Redis

```
User → Web App (Next.js) → MongoDB
                        → Redis
```

---

# ⚙️ Setup Steps

## 1. Clone Repository

```bash
git clone https://github.com/iemafzalhassan/EasyShop.git
cd EasyShop
```

---

## 2. Create Environment File

```bash
nano .env.local
```

```env
MONGODB_URI=mongodb://easyshop-mongodb:27017/easyshop
NEXTAUTH_URL=http://localhost:3000
NEXT_PUBLIC_API_URL=http://localhost:3000/api
NEXTAUTH_SECRET=devsecret
JWT_SECRET=devjwtsecret
```

---

## 3. Run Application

```bash
docker compose up -d
```

Access:

```
http://localhost:3000
```

---

# 🧩 Enhancements Done (Day 34 Tasks)

---

## ✅ Task 1: Multi-Container Setup

Added Redis to existing stack:

```yaml
redis:
  image: redis:7
  container_name: easyshop-redis
  ports:
    - "6379:6379"
```

---

## ✅ Task 2: depends_on & Healthchecks

### MongoDB Healthcheck

```yaml
healthcheck:
  test: ["CMD", "mongosh", "--eval", "db.adminCommand('ping')"]
  interval: 5s
  timeout: 5s
  retries: 5
```

### Service Dependency

```yaml
depends_on:
  mongodb:
    condition: service_healthy
```

### 🔍 Observation

* App waits until MongoDB is **fully ready**
* Prevents startup failures

---

## ✅ Task 3: Restart Policies

### Used:

```yaml
restart: always
```

### Tested:

```bash
docker kill easyshop-mongodb
```

✔ Container restarted automatically

---

### 🔄 Restart Policy Comparison

| Policy     | Behavior                  |
| ---------- | ------------------------- |
| always     | Always restarts container |
| on-failure | Restarts only on crash    |
| no         | No restart                |

### 🧠 Use Cases

* `always` → Database (production)
* `on-failure` → Applications
* `no` → Debugging

---

## ✅ Task 4: Custom Dockerfile

Used existing Dockerfile from project.

### Rebuild Command:

```bash
docker compose up --build
```

✔ Code changes reflected immediately

---

## ✅ Task 5: Networks & Volumes

### Network

```yaml
networks:
  easyshop-network:
```

### Volume (MongoDB Data Persistence)

```yaml
volumes:
  - mongo-data:/data/db
```

```yaml
volumes:
  mongo-data:
```

### Labels

```yaml
labels:
  project: "easyshop"
  env: "dev"
```

---

## ✅ Task 6: Scaling (Bonus)

### Command:

```bash
docker compose up --scale easyshop=3
```

---

### ❌ Issue Faced

```
Port 3000 already allocated
```

---

### 🧠 Explanation

* Multiple containers cannot bind to the same host port
* Docker Compose lacks built-in load balancing

---

### 💡 Solution (Production)

* Use **Nginx / Reverse Proxy**
* Use **Load Balancer**
* Use **Kubernetes Service**

---

# 🧪 Commands Used

```bash
docker compose up -d
docker compose up --build
docker compose down
docker compose up --scale easyshop=3
docker ps
docker kill <container-id>
```

---

# 📚 Key Learnings

* `depends_on` does NOT guarantee readiness
* Healthchecks solve startup dependency issues
* Restart policies are critical for production stability
* Named volumes ensure data persistence
* Docker Compose scaling has limitations
* Real scaling requires load balancing or Kubernetes

---

# 🔥 Conclusion

Successfully built and enhanced a **production-like multi-container setup** using Docker Compose by:

* Adding Redis cache
* Implementing healthchecks
* Managing service dependencies
* Applying restart policies
* Using networks and volumes
* Testing scaling limitations

---

✅ This setup closely resembles real-world DevOps environments.
![Uploading image.png…]()

<img width="1583" height="827" alt="image" src="https://github.com/user-attachments/assets/4eaa095d-ec44-446c-b72a-ae1c1a6e3f87" />


