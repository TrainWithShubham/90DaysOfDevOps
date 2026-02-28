# Dockerfile: Build Your Own Images

---

## Task 1: Your First Dockerfile

---

Step 1: Create a Dockerfile with below details

```bash
vi Dockerfile
```

![alt text](image-35.png)

Step 2: Build the docker image using below command

```bash
docker build -t my-ubuntu:v1
```

![alt text](image-36.png)

Step 3: Check whether the Docker image is created successfully using below command

```bash
docker images
```

![alt text](image-37.png)

Step 4: Run the docker image by using below command

```bash
docker run $IMAGE_ID
```

![alt text](image-38.png)

---

## TASK 2 : Dockerfile Instructions

---

![alt text](image-39.png)

---

## TASK 3 : CMD vs ENTRYPOINT

---

![alt text](image-40.png)

![alt text](image-41.png)

![alt text](image-42.png)

![alt text](image-43.png)

![alt text](image-44.png)

CMD - It is a default command, but still it can be overridden during runtime

![alt text](image-45.png)

![alt text](image-46.png)

![alt text](image-47.png)

![alt text](image-48.png)

Entrypoint - In entrypoint the argument you pass after docker run imageid those argument will be appended to the entrypoint, this means whatever you add infront of docker run imageid those values will act as arguments for the command mentioned in the ENTRYPOINT

---

## TASK 4 : Build a simple Web App image

---

![alt text](image-50.png)

![alt text](image-51.png)

![alt text](image-52.png)

![alt text](image-53.png)

![alt text](image-54.png)

---

## TASK 5 : .dockerignore

---

![alt text](image-55.png)

![alt text](image-56.png)

![alt text](image-57.png)

![alt text](image-58.png)

![alt text](image-59.png)

.dockerignore file ignore the files in the container which you mention in the file

---

## TASK 6 : Build Optimization

---

### 📌 Objective

- Understand how Docker layer caching works
- Observe how changing one instruction affects rebuild
- Learn why Dockerfile instruction order matters
- Optimize Dockerfile for faster builds

---

### 🧱 What I Learned About Docker Layer Caching

When Docker builds an image:

- It executes instructions **top to bottom**
- Each instruction creates a **layer**
- Docker stores layers in cache
- During rebuild, Docker checks if a layer changed

If nothing changed → ✅ Uses cache  
If something changed → ❌ Rebuilds from that layer onward

---

### 🔍 Practical Observations


![alt text](image-60.png)

![alt text](image-61.png)

![alt text](image-62.png)

![alt text](image-63.png)

![alt text](image-64.png)

![alt text](image-65.png)
