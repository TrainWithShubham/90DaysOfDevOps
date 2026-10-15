# Day 30: Docker Images, Layers & Container Lifecycle

Today, I deep-dived into the core of how Docker images are built, how they share space, and how to triage running containers directly from the host.

### Task 1: Docker Images & Size Comparison
**Action:** Pulled `nginx`, `ubuntu`, and `alpine` images to compare their footprints. Investigated an image using `docker inspect` and forcefully removed a base image locked by a dead container (`docker rm -f` followed by `docker rmi`).
**Observation:** `alpine` is ~13MB compared to `ubuntu` (~160MB) because Alpine strips out heavy `glibc` libraries for a minimal `musl libc` environment, drastically reducing the attack surface.

![Task 1 - Image Size Comparison](./01-image-size-comparison.png)

### Task 2: Unpacking Image Layers
**Action:** Ran `docker image history nginx` to inspect the internal architecture of a Docker image.
**Observation:** Images are stacked Lego blocks. The base OS (`Debian 13 trixie`) took 87.5MB, and the main Nginx installation took 95.9MB. The `0B` layers are just metadata instructions (ENV, EXPOSE). Docker caches and shares these heavy OS layers across different containers to save disk space and network bandwidth.

![Task 2 - Nginx Image Layers](./02-nginx-image-layers.png)

### Task 3: The Container Lifecycle
**Action:** Manually transitioned a container through its complete lifecycle:
1. `docker create` -> **Created** (Ready on disk, no CPU/RAM used)
2. `docker start` -> **Up** (Process actively running)
3. `docker pause` -> **Paused** (Frozen in RAM, 0% CPU usage)
4. `docker stop` -> **Exited (0)** (Graceful shutdown via `SIGTERM`)
5. `docker kill` -> **Exited (137)** (Force killed via `SIGKILL`)

![Task 3 - Container Lifecycle States](./03-container-lifecycle-states.png)

### Task 4: Live Triage of a Running Container
**Action:** Deployed a detached Nginx container (`docker run -d -p 8080:80`) and executed live triage:
- Watched live traffic logs using `docker logs -f` and caught a standard 404 for a missing `favicon.ico`.
- Extracted the internal Docker bridge IP (`172.17.0.2`) using `docker inspect`.
- Ran commands inside the container without entering the shell: `docker exec live-web cat /etc/os-release`.

![Task 4 - Live Triage & Exec](./04-live-triage.png)

### Task 5: System Cleanup
**Action:** Automated the cleanup of the Docker environment to prevent disk space hoarding on the host machine.
- Stopped all running processes dynamically: `docker stop $(docker ps -q)`
- Removed all dead containers: `docker rm $(docker ps -aq)`
- Nuked all unused layers, caches, and images: `docker system prune -a --volumes`
**Result:** Successfully reclaimed 139.2MB of disk space.

![Task 5 - Docker System Cleanup](./05-docker-system-cleanup.png)
