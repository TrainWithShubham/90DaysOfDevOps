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


**Task 3: Container Lifecycle**
<img width="780" height="109" alt="Screenshot 2026-03-09 at 12 51 12 PM" src="https://github.com/user-attachments/assets/2cb30c31-9b72-4628-ac64-923ff1479da4" />

<img width="835" height="97" alt="Screenshot 2026-03-09 at 12 52 16 PM" src="https://github.com/user-attachments/assets/c009e9e9-2162-43c8-b463-b9c919daa247" />

<img width="912" height="61" alt="Screenshot 2026-03-09 at 12 52 50 PM" src="https://github.com/user-attachments/assets/be88e81b-a93e-447a-bcc2-886f515d5e89" />

<img width="885" height="165" alt="Screenshot 2026-03-09 at 12 53 34 PM" src="https://github.com/user-attachments/assets/215914b2-9667-430b-bd9e-8791e795c873" />

<img width="903" height="230" alt="Screenshot 2026-03-09 at 12 55 01 PM" src="https://github.com/user-attachments/assets/175dd049-1f31-4566-9e7e-3654ae87c50c" />


**Task 4: Working with Running Containers**

<img width="933" height="342" alt="Screenshot 2026-03-09 at 1 01 48 PM" src="https://github.com/user-attachments/assets/c7b3c47a-b15b-4eb7-beca-09cba3f81885" />

<img width="661" height="283" alt="Screenshot 2026-03-09 at 1 03 25 PM" src="https://github.com/user-attachments/assets/b4921493-1a8c-40d5-9995-308e1db2d3e9" />

dockert system prune

<img width="384" height="63" alt="Screenshot 2026-03-09 at 1 10 10 PM" src="https://github.com/user-attachments/assets/e52b9342-1c6f-442c-aa0d-4de34c3df93a" />





