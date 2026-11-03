# Day 30 - Docker Images & Container Lifecycle

## Objective

- Learn Docker image management, understand image layers, practice the complete container lifecyle, work with running contianers, and perform Docker cleanup.

---

## Task 1: Docker Images

### 1. pull nginx ,ubuntu, and alpine images from Docker hub.

![nginx-pull-image](day-30-Task-images/nginx_pull_image.png)


![ubuntu-alpine](day-30-Task-images/both_pulling.png)

---

### 2. List Available Images

| image | Observation |
|--------|-------------|
| Alpine | Lightweight |
| ubuntu | Genral-purpose Linux image |
| Nginx | Web Server image |

![image](day-30-Task-images/imags_list.png)


---

### 3. compare `ubuntu` Vs `alpine - why is one much smaller

- alpine does not include common tools like curl, git , python , or even the bash shell by default 

- BusyBox Power: It replaces standard Linux core utilities with BusyBox, a single executable that contains tiny versions of many common UNIX utilities.

---

### 4. inspect Docker image

- Verified image metadata Including repository, entrypoint, expossed port, envornment variable, and image layers.

![nginx-inspect](day-30-Task-images/nginx_ispect_container.png)

----
### 5: Remove an Unuse image

- Remove the Unuse image from local repository 

![Unuse-image-remove](day-30-Task-images/remove_image_task1.png)



## Task 2: Image Layers

### 1. show the history of dockaer Images

#### Key Observation 

 - Every Dockerfile instruction Create a new Layer
 - metadata instruction create `0B` layers.
 - cached layers improve build performance.


 ![nginx-history](day-30-Task-images/docker_history_image.png)

 ----


 ## Task: 3 Contaienr Lifecycle

 - practice the full lifecycle on one contianer understtod how to container works.

1. Create Container
2. Start Container
3. Pause Container
4. Unpause Container
5. Stop Container
6. Restart Container
7. Kill Container
8. Remove Container


![Docker-container Life Cycle](day-30-Task-images/container_life_cycleTask-3.png)

---


## Task 4: Working With Running Container

### 1. Start an Nginx Container in detached mode port expost `80`

![run Nginx contianer Detached mode](day-30-Task-images/ngix_detached_mode_container-task-4.png)

-------

### 2. View contianer logs histoy `normal logs`

![Nginx-logs](day-30-Task-images/nginx_logs_task-4.png)

### 3. View REal-time logs 
 - see the container live logs use in real industyr to see live logs of container us ein monitoring to send alerts.

 ![Nginx-live-logs](day-30-Task-images/live_logs-task-4.png)

 -------

### 4. Exec container and look aroung the filesystem

 - Go to inside container and obeserb the filese system contianer also have filesystem in this system have container filese to run the container process.


 ![file-system-inside-contianer](day-30-Task-images/view_inside-contianer-filesystem-task-4.png)

---

### 5. Run single command inside the container without entering it 

![Run cmd inside contianer without go inside it](day-30-Task-images/run_cmd-insidecontier-without-goinside-int-task-4.png)


----


### 6. Inspect the Container - find its ip address , port mappings, and mounts

- See Ip address
- port mapping
- mounts

![see-ip address inspect](day-30-Task-images/ispecgt-cotniere-ip-address-task-4.png)


![port-mapping](day-30-Task-images/inspect-container-ports-task-4.png)

---

## Task 5: cleanup

### 1. Stop all Running Containers in one command

![Stop-sll-container-one-cmd](day-30-Task-images/cleanu-task-stop-all-container-task-5.png)


-----


### 2. Remove all Stopped Container in one command

![Rm-all-stopped-container-one-cmd](day-30-Task-images/remove-all-stoped-contianer-task-5.png)

---

### 3. Remove unused images

![Remove-unused-image](day-30-Task-images/remove-iamges-all-unuse-task-5.png)

---

### 4. Check how much disk space Docker is Usin

![check-disk space](day-30-Task-images/disk-space-check-task-5.png)

