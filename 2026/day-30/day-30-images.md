**Task 1: Docker Images

Pull the nginx, ubuntu, and alpine images from Docker Hub
List all images on your machine — note the sizes - docket images
Compare ubuntu vs alpine — why is one much smaller? Alpine
Inspect an image — what information can you see?
Remove an image you no longer need**
=============================================================
images pulled

<img width="612" height="147" alt="Screenshot 2026-03-09 at 12 09 25 PM" src="https://github.com/user-attachments/assets/bd9e84cc-a2bc-41d3-9276-b70f289f0eb9" />

inspect for nginx

<img width="980" height="724" alt="Screenshot 2026-03-09 at 12 13 03 PM" src="https://github.com/user-attachments/assets/ef13fe72-4eb6-4bf7-a2f1-b3eccdbc44dd" />

removed image (rmi)

<img width="700" height="392" alt="Screenshot 2026-03-09 at 12 14 44 PM" src="https://github.com/user-attachments/assets/edfb7929-4468-4c84-ac3f-1b3814afe646" />

**Task 2: Image Layers

Run docker image history nginx — what do you see?
Each line is a layer. Note how some layers show sizes and some show 0B
Write in your notes: What are layers and why does Docker use them?**
===========================================
<img width="817" height="302" alt="Screenshot 2026-03-09 at 12 18 15 PM" src="https://github.com/user-attachments/assets/f06cd2f0-2eba-4646-b022-f9f52263f343" />

**Layers:**
A Docker image is made of multiple read-only layers created from Dockerfile instructions.

**Why Docker uses layers:**
Faster builds
Shared storage
Efficient image downloads
Easy image updates
