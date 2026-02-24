### Pull nginx, ubuntu and alpine and compare their sizes

![alt text](image.png)

### Inspect an image

![alt text](image-1.png)

### Remove an image

![alt text](image-2.png)

### sudo docker image history nginx

![alt text](image-3.png)

### What are layers and why does docker use them?

Docker layers are immutable, read-only file system changes created by each instruction in a Dockerfile, stacked up on each other to form an image. Docker uses them across containers to optimize storage, fast builds by caching them and enable lightweight containers.