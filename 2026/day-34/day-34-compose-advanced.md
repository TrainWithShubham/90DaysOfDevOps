# Day 34 – Docker Compose: Real-World Multi-Container Apps

Aaj ke din hum advanced Docker Compose seekhenge. Ye real projects jaisa hai - app + database + cache ke saath, health checks, restart policies, aur dependencies handle karna.

---

## Task 1: Build Your Own App Stack (Web + DB + Cache)

Maine Python Flask app liya jisme Postgres database aur Redis cache hai.

### Project Structure
```
myapp/
├── app.py
├── requirements.txt
├── Dockerfile
└── docker-compose.yml
```

### app.py (Simple Flask App)
```python
from flask import Flask, jsonify
import os
import psycopg2
import redis

app = Flask(__name__)

# Database connection
def get_db_connection():
    conn = psycopg2.connect(
        host=os.environ['DB_HOST'],
        database=os.environ['DB_NAME'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD']
    )
    return conn

# Redis connection
def get_redis_client():
    r = redis.Redis(
        host=os.environ['REDIS_HOST'],
        port=6379,
        decode_responses=True
    )
    return r

@app.route('/')
def home():
    return jsonify({"message": "Hello from Flask + Postgres + Redis!"})

@app.route('/status')
def status():
    # Check DB
    try:
        conn = get_db_connection()
        conn.close()
        db_status = "OK"
    except:
        db_status = "FAIL"
    
    # Check Redis
    try:
        r = get_redis_client()
        r.ping()
        redis_status = "OK"
    except:
        redis_status = "FAIL"
    
    return jsonify({"db": db_status, "redis": redis_status})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

### requirements.txt
```
flask
psycopg2-binary
redis
gunicorn
```

### Dockerfile
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
```

### docker-compose.yml
```yaml
version: '3.8'

services:
  web:
    build: .
    container_name: my-flask-app
    ports:
      - "5000:5000"
    environment:
      - DB_HOST=db
      - DB_NAME=myapp
      - DB_USER=postgres
      - DB_PASSWORD=postgres
      - REDIS_HOST=redis
    depends_on:
      - db
      - redis

  db:
    image: postgres:15-alpine
    container_name: my-postgres
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    container_name: my-redis

volumes:
  postgres-data:
```

---

## Task 2: depends_on & Health Checks

Ab hum dependency proper handle karenge taaki app tabhi start ho jab database ready ho, sirf start ho gayi ho.

### docker-compose.yml with Healthcheck
```yaml
version: '3.8'

services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
    # ... rest same

  db:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine

volumes:
  postgres-data:
```

### Key Points:
- **condition: service_healthy** - app tabhi start hoga jab DB "healthy" ho
- **healthcheck** - Docker yeh command run karega. Agar return karega "healthy" tab DB ready maana jayega
- **pg_isready** - Postgres ka command hai jo check karta hai ki DB ready hai ya nahi

---

## Task 3: Restart Policies

Restart policies se hum define karte hain ki container kaise restart ho.

### Different Restart Policies:

| Policy | Kab Restart Hota Hai |
|--------|---------------------|
| `no` | Kabhi nahi (default) |
| `always` | Hamesha, chahe koi bhi reason ho |
| `on-failure` | Sirf tabhi jab container fail ho |
| `unless-stopped` | Always jaise, par manually stop nahi karega |

### Example with Restart Policies:
```yaml
services:
  web:
    build: .
    restart: always
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:15-alpine
    restart: always
    # ... rest
```

### Testing:
```bash
# Container ko manually kill karein
docker kill my-postgres

# Docker automatically restart kar dega!
docker ps  # Dekho container wapas chal gaya
```

### Kab Use Karna Kya Hai:
- **always** - Database, cache jaisi important services ke liye
- **on-failure** - Background jobs, workers ke liye jo kabhi fail ho sakte hain
- **no** - Development ke liye jab manually control chahiye

---

## Task 4: Custom Dockerfiles in Compose

Pichle example mein humne build: . use kiya hai. Ab code change karke rebuild karte hain.

### Steps:
```bash
# 1. Code change karein app.py mein
# 2. Rebuild karo
docker compose up --build

# 3. Restart karo (agar already running hai)
docker compose restart web
```

### build options in compose:
```yaml
services:
  web:
    build:
      context: ./app
      dockerfile: Dockerfile.prod
    # Or simple: build: ./app
```

---

## Task 5: Named Networks & Volumes

Explicit networks aur volumes define karna zyada clear hota hai.

### docker-compose.yml with explicit networks/volumes:
```yaml
version: '3.8'

services:
  web:
    build: .
    networks:
      - frontend
      - backend
    labels:
      - "app=myflask"

  db:
    image: postgres:15-alpine
    networks:
      - backend
    volumes:
      - postgres-data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

volumes:
  postgres-data:
```

### Benefits:
- **Explicit networks** - Security ke liye zyada accha, alag-alag services alag networks mein
- **Labels** - Organization ke liye helpful, monitoring tools mein识别 ke liye
- **Named volumes** - Clear hai ki kaunsa volume kaunse service ke liye hai

---

## Task 6: Scaling (Bonus)

Docker compose se app ko scale kar sakte hain - multiple instances!

### Try it:
```bash
docker compose up --scale web=3 -d
```

### What Happens?
- 3 web containers chalenge
- Lekin problem hai - saare 5000 port use karenge
- Error milega: "port is already allocated"

### Problem:
- Docker compose port mapping sirf ek container ke liye allow karta hai
- Load balancer chahiye multiple replicas ke liye
- Docker Swarm ya Kubernetes mein ye automatically hota hai

### Solution:
```yaml
# ports ke bajaye expose use karo (internal only)
services:
  web:
    expose:
      - "5000"
    # Ab scale karo
    # Par phir bhi external access ke liye proxy/lb chahiye
```

---

## Summary - Key Commands:

| Command | Purpose |
|---------|---------|
| `docker compose up -d` | Background mein chalana |
| `docker compose up --build` | Code change ke baad rebuild |
| `docker compose up --scale web=3` | Scale karne ki koshish |
| `docker compose logs -f` | Logs dekhna |
| `docker compose restart` | Restart all |
| `docker compose down` | Sabhi hata dena |

### Key Concepts:
1. **depends_on with healthcheck** - App wait karega DB ready hone ka
2. **Restart policies** - Auto-restart ke liye
3. **Custom Dockerfile** - build: use karke
4. **Explicit networks** - Better security
5. **Scaling** - Port conflict issue hai simple compose mein