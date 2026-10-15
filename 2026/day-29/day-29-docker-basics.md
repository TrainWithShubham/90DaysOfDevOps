# Day 29: Introduction to Docker & Container Mechanics

**Author:** Rashid Khan  
**Track:** #90DaysOfDevOps (2026)  
**Milestone:** Day 29 Task Documentation & Hands-on Lab Log  

---

## Task 1: What is Docker?

### 1. What is a container and why do we need them?
Before running containers on my EC2 instance today, I thought containers were just stripped-down virtual machines. Seeing them live completely changed my mental model:

* **What it is in my own words:** A container is simply an isolated, sandboxed Linux process running directly on the host machine's kernel. It bundles my application code along with its exact dependencies, system libraries, and runtime configs so that nothing from the outside host can tamper with it, and it cannot leak outside unless I explicitly map ports or storage.
* **Why we need them:** During my earlier days working with Linux services, package versions constantly conflicted. If my host machine had one version of a library and an application required an older release, system utilities would break. Containers eliminate the classic excuse: *"it works fine on my local machine, why is production crashing?"* If an image runs on my machine, it runs identically on an EC2 server or a staging cluster.
* **Under the Hood (Linux Kernel Features):** Docker doesn't emulate hardware; it relies on two native Linux subsystems:
  * **Namespaces (Isolation Walls):** Restricts what the process can *see*. The PID namespace gives the container its own isolated process tree (making its entrypoint process PID 1). The NET namespace provides private virtual network interfaces and routing tables. The MNT namespace isolates filesystem mount points.
  * **Control Groups / cgroups (Resource Limits):** Restricts what the process can *use*. It prevents a memory leak or an unconstrained CPU spike inside a container from starving the host EC2 instance.

### 2. Containers vs. Virtual Machines — What's the Real Difference?
Here is how I distinguish them based on my hands-on setup:

| Feature | Virtual Machines (What I used previously) | Containers / Docker (What I ran today) |
| :--- | :--- | :--- |
| **Architecture** | Relies on a Hypervisor (Type 1 or 2) to emulate physical hardware | Runs directly on Host OS via the Docker container engine |
| **Kernel / OS** | Packs an entire Guest OS (boots its own dedicated kernel) | Shares the host machine's Linux kernel directly |
| **Boot Latency** | 1 to 3 minutes (virtual BIOS boot, kernel init, systemd startup) | Sub-second / milliseconds (it just spawns a regular process) |
| **Resource Usage** | Static memory/CPU reservation upfront, whether used or idle | Consumes only active memory/CPU cycles on demand |
| **Disk Footprint** | 10 GB to 50 GB disk images (`.iso`, `.vmdk`) | 10 MB to 200 MB lightweight layered OCI images |
| **Performance** | Performance penalty due to hardware instruction emulation | Near-native bare-metal execution speeds directly on host CPU |

### 3. Docker Architecture in My Own Words
The Docker architecture is built on a client-server model consisting of 5 distinct components:

* **Docker Client (`docker` CLI):** The command-line interface on my terminal where I type commands like `docker run` or `docker ps`. It doesn't actually create containers; it just packages my request into a REST API call.
* **Docker Daemon (`dockerd`):** The background service constantly listening on `/var/run/docker.sock`. When the client speaks, the daemon does the heavy lifting: it coordinates with `containerd`/`runc`, builds network bridges, pulls image layers, and manages process life.
* **Docker Image:** A read-only snapshot or blueprint. It is immutable and built out of read-only stacked filesystem layers.
* **Docker Container:** An active, running instance spawned from an image. Docker adds a thin read/write layer on top of the image's read-only layers so the container can write temporary files and runtime logs.
* **Docker Registry:** The distribution library where images live. By default, my daemon pulled from **Docker Hub**, but in production setups, private registries like AWS ECR are used.

```text
       [ MY EC2 TERMINAL ]
       Docker Client (CLI)
                |
                | (REST API via /var/run/docker.sock)
                v
     [ DOCKER DAEMON (dockerd) ]  <======== Pulls Image ========> [ DOCKER REGISTRY ]
     - Listens on UNIX socket                                      (Docker Hub)
     - Manages Namespaces & Cgroups
                |
                |-- Spawns & Manages --> [ CONTAINER: test-nginx ] (Process + R/W Layer)
                |-- Spawns & Manages --> [ CONTAINER: my-web-server ] (Host:8080 -> Cont:80)
                |-- Stores & Caches  --> [ IMAGES: ubuntu, nginx, hello-world ]
```

---

## Task 2: Install Docker & Verification

### 1. Installation Workflow on EC2
I set up the Docker engine on my Ubuntu EC2 terminal, started the daemon, and handled group permissions so I wouldn't need to prefix every command with `sudo`:

```bash
# 1. Update package database and install Docker engine
sudo apt update
sudo apt install -y docker.io

# 2. Start Docker service and enable it across reboots
sudo systemctl enable --now docker

# 3. Add my 'ubuntu' user to the docker group
sudo usermod -aG docker $USER

# 4. Activate group membership without logging out
newgrp docker

# 5. Verify the version
docker --version
```
*Output confirmed:* Docker Engine version verified and active on Ubuntu host.

### 2. Running `hello-world` & Deconstructing the Trace
I executed:
```bash
docker run hello-world
```

**What the Output Explained (Step-by-Step Under the Hood):**
1. My CLI client contacted the local Docker daemon at `/var/run/docker.sock`.
2. The daemon checked local storage for `hello-world:latest`, found nothing, and output:  
   `Unable to find image 'hello-world:latest' locally`.
3. The daemon queried Docker Hub, pulled the image manifest and layers, and verified the hash digest.
4. The daemon built an isolated container execution space using Linux namespaces and invoked the greeting binary inside the image.
5. The binary printed the *"Hello from Docker!"* confirmation block to stdout, sent it back through the client to my terminal, and the process exited immediately.

---

## Task 3: Run Real Containers (Hands-on Execution & Triage)

### 1. Running an Ubuntu Container in Interactive Mode (`-it`)
To experience container isolation firsthand, I launched a minimal Ubuntu container:
```bash
docker run -it ubuntu bash
```

**My Observations Inside the Container Shell:**
* **Isolated Environment:** Running `cat /etc/os-release` showed Ubuntu inside the container, regardless of my host customizations.
* **Private Hostname:** My terminal prompt switched to `root@009638b9df2a:/#`. The hostname matched the unique container ID hash, not my EC2 private IP.
* **Process Tree Isolation:** When I ran `ps aux`, there was no `systemd`, no `cron`, and no host processes visible—only PID 1 (which was `/bin/bash`) and my own `ps` command.
* **Stopping Mechanism:** As soon as I typed `exit`, PID 1 terminated, which automatically stopped the container because a container only lives as long as its main foreground process.

### 2. Running Nginx & Real-World Port Conflict Triage
Next, I attempted to spin up a web server exposed on standard HTTP port 80:
```bash
docker run -d -p 80:80 --name test-nginx nginx
```

**The Error I Encountered:**
```text
docker: Error response from daemon: failed to bind host port 0.0.0.0:80/tcp: address already in use
```

**My Diagnosis & Fix:**
1. I realized my EC2 host was already running a native Nginx service from my previous Week 1 Linux systemd practice.
2. I removed the dead container state first so the name wouldn't collide later:
   ```bash
   docker rm test-nginx
   ```
3. I audited port 80 on the host to confirm who was occupying it:
   ```bash
   sudo ss -tulpn | grep :80
   ```
4. I stopped and disabled the host systemd service to free socket 80:
   ```bash
   sudo systemctl stop nginx
   sudo systemctl disable nginx
   ```
5. I re-ran the container:
   ```bash
   docker run -d -p 80:80 --name test-nginx nginx
   ```
6. **Verification:** Ran `curl -I http://localhost` and got a clean `HTTP/1.1 200 OK` response.

### 3. Container Lifecycle Management Commands
I practiced tracking states and cleaning up stopped containers:

```bash
# View only actively running containers
docker ps

# View all containers including stopped ones (hello-world, ubuntu, test-nginx)
docker ps -a

# Gracefully terminate the running nginx container (sends SIGTERM)
docker stop test-nginx

# Permanently delete the container and its writable scratch layer
docker rm test-nginx

# Verify cleanup
docker ps -a
```

---

## Task 4: Deep Dive Exploration (Flags, Logs & Exec)

### 1. Detached Mode (`-d`) vs. Foreground Mode
* When I ran `docker run -it ubuntu bash`, my terminal was locked inside the container shell.
* When I ran `docker run -d ...`, Docker decoupled the execution from my shell, printed the 64-character long container ID, and returned my shell prompt immediately. The container ran quietly as a background daemon process.

### 2. Custom Naming (`--name`) & Port Mapping (`-p host:container`)
I launched an Nginx instance on non-standard port 8080 with an identifiable custom name:
```bash
docker run -d -p 8080:80 --name my-web-server nginx
```
* **Why `--name my-web-server` matters:** Instead of dealing with random autogenerated names like `flamboyant_morse`, I can target my container directly in scripts using `my-web-server`.
* **Why `-p 8080:80` matters:** The container listens on internal port 80. Docker iptables/nftables rules forward traffic hitting the host's port 8080 into the container's private port 80.

### 3. Inspecting Container Logs (`docker logs`)
Because detached containers don't dump text onto the terminal, debugging requires inspecting the container's stdout/stderr stream:
```bash
# Dump historical logs
docker logs my-web-server

# Inspect the last 10 log entries with exact timestamps
docker logs --tail 10 -t my-web-server

# Live stream incoming HTTP access logs in real-time (like tail -f)
docker logs -f my-web-server
```

### 4. Running Commands Inside a Running Container (`docker exec`)
Instead of stopping a container or rebuilding an image to make a quick check, I used `docker exec` to inject commands directly into its running namespace:

* **One-off diagnostic check:**
  ```bash
  docker exec my-web-server nginx -v
  ```
* **Interactive Shell & Live Web Page Modification:**
  ```bash
  docker exec -it my-web-server bash
  ```
  Inside the container shell, I attempted to rewrite the index file:
  ```bash
  echo "<h1>Hello from Rashid's Docker Container (Day 29)</h1>" > /usr/share/nginx/html/index.htm
  exit
  ```
* **The Typo & Troubleshooting Lesson:**
  When I tested with `curl http://localhost:8080`, I still saw the default *"Welcome to nginx!"* page!  
  *Root Cause:* I accidentally created `index.htm` instead of `index.html`. Nginx's internal routing checks `index.html` first.  
  *The Direct Fix:* I fixed it cleanly from the outside using `docker exec`:
  ```bash
  docker exec my-web-server bash -c 'echo "<h1>Hello from Rashid Docker Container (Day 29)</h1>" > /usr/share/nginx/html/index.html'
  ```
  Testing again with `curl http://localhost:8080` immediately returned my custom heading:  
  `<h1>Hello from Rashid Docker Container (Day 29)</h1>`.

### 5. Final Lab Teardown
```bash
docker stop my-web-server
docker rm my-web-server
```

---

## Key Engineering Takeaways from Day 29
1. **Containers are isolated processes, not hardware:** Seeing `ps aux` inside Ubuntu having only PID 1 proved that containers simply share the host kernel under strict namespace boundaries.
2. **Port binding requires vigilance:** A container cannot bind to a host port if a native daemon or another container already owns that socket. Triage tools (`ss -tulpn`) remain essential.
3. **Immutability vs State:** Any changes made inside a running container using `docker exec` live only in the temporary read/write layer. Once I run `docker rm`, those manual edits are destroyed. To make permanent changes, I will need Dockerfiles.
