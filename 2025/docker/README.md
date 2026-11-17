# Week 5: Docker Basics & Advanced Challenge

Welcome to the Week 5 Docker Challenge! In this task, you will work with Docker concepts and tools taught by Shubham Bhaiya. This challenge covers the following topics:

- **Introduction and Purpose:** Understand Docker’s role in modern development.
- **Virtualization vs. Containerization:** Learn the differences and benefits.
- **Build Kya Hota Hai:** Understand the Docker build process.
- **Docker Terminologies:** Get familiar with key Docker terms.
- **Docker Components:** Explore Docker Engine, images, containers, and more.
- **Project Building Using Docker:** Containerize a sample project.
- **Multi-stage Docker Builds / Distroless Images:** Optimize your images.
- **Docker Hub (Push/Tag/Pull):** Manage and distribute your Docker images.
- **Docker Volumes:** Persist data across container runs.
- **Docker Networking:** Connect containers using networks.
- **Docker Compose:** Orchestrate multi-container applications.
- **Docker Scout:** Analyze your images for vulnerabilities and insights.

Complete all the tasks below and document your steps, commands, and observations in a file named `solution.md`. Finally, share your experience on LinkedIn using the provided guidelines.

---

## Challenge Tasks

### Task 1: Introduction and Conceptual Understanding
1. **Write an Introduction:**  
   - In your `solution.md`, provide a brief explanation of Docker’s purpose in modern DevOps.
   - Compare **Virtualization vs. Containerization** and explain why containerization is the preferred approach for microservices and CI/CD pipelines.

---

### Task 2: Create a Dockerfile for a Sample Project
1. **Select or Create a Sample Application:**  
   - Choose a simple application (for example, a basic Node.js, Python, or Java app that prints “Hello, Docker!” or serves a simple web page).

2. **Write a Dockerfile:**  
   - Create a `Dockerfile` that defines how to build an image for your application.
   - Include comments in your Dockerfile explaining each instruction.
   - Build your image using:
     ```bash
     docker build -t <your-username>/sample-app:latest .
     ```

3. **Verify Your Build:**  
   - Run your container locally to ensure it works as expected:
     ```bash
     docker run -d -p 8080:80 <your-username>/sample-app:latest
     ```
   - Verify the container is running with:
     ```bash
     docker ps
     ```
   - Check logs using:
     ```bash
     docker logs <container_id>
     ```

---

### Task 3: Explore Docker Terminologies and Components
1. **Document Key Terminologies:**  
   - In your `solution.md`, list and briefly describe key Docker terms such as image, container, Dockerfile, volume, and network.
   - Explain the main Docker components (Docker Engine, Docker Hub, etc.) and how they interact.

---

### Task 4: Optimize Your Docker Image with Multi-Stage Builds
1. **Implement a Multi-Stage Docker Build:**  
   - Modify your existing `Dockerfile` to include multi-stage builds.  
   - Aim to produce a lightweight, **distroless** (or minimal) final image.
2. **Compare Image Sizes:**  
   - Build your image before and after the multi-stage build modification and compare their sizes using:
     ```bash
     docker images
     ```
3. **Document the Differences:**  
   - Explain in `solution.md` the benefits of multi-stage builds and the impact on image size.

---

### Task 5: Manage Your Image with Docker Hub
1. **Tag Your Image:**  
   - Tag your image appropriately:
     ```bash
     docker tag <your-username>/sample-app:latest <your-username>/sample-app:v1.0
     ```
2. **Push Your Image to Docker Hub:**  
   - Log in to Docker Hub if necessary:
     ```bash
     docker login
     ```
   - Push the image:
     ```bash
     docker push <your-username>/sample-app:v1.0
     ```
3. **(Optional) Pull the Image:**  
   - Verify by pulling your image:
     ```bash
     docker pull <your-username>/sample-app:v1.0
     ```

---

### Task 6: Persist Data with Docker Volumes
1. **Create a Docker Volume:**  
   - Create a Docker volume:
     ```bash
     docker volume create my_volume
     ```
2. **Run a Container with the Volume:**  
   - Run a container using the volume to persist data:
     ```bash
     docker run -d -v my_volume:/app/data <your-username>/sample-app:v1.0
     ```
3. **Document the Process:**  
   - In `solution.md`, explain how Docker volumes help with data persistence and why they are useful.

---

### Task 7: Configure Docker Networking
1. **Create a Custom Docker Network:**  
   - Create a custom Docker network:
     ```bash
     docker network create my_network
     ```
2. **Run Containers on the Same Network:**  
   - Run two containers (e.g., your sample app and a simple database like MySQL) on the same network to demonstrate inter-container communication:
     ```bash
     docker run -d --name sample-app --network my_network <your-username>/sample-app:v1.0
     docker run -d --name my-db --network my_network -e MYSQL_ROOT_PASSWORD=root mysql:latest
     ```
3. **Document the Process:**  
   - In `solution.md`, describe how Docker networking enables container communication and its significance in multi-container applications.

---

### Task 8: Orchestrate with Docker Compose
1. **Create a docker-compose.yml File:**  
   - Write a `docker-compose.yml` file that defines at least two services (e.g., your sample app and a database).
   - Include definitions for services, networks, and volumes.
2. **Deploy Your Application:**  
   - Bring up your application using:
     ```bash
     docker-compose up -d
     ```
   - Test the setup, then shut it down using:
     ```bash
     docker-compose down
     ```
3. **Document the Process:**  
   - Explain each service and configuration in your `solution.md`.

---

### Task 9: Analyze Your Image with Docker Scout
1. **Run Docker Scout Analysis:**  
   - Execute Docker Scout on your image to generate a detailed report of vulnerabilities and insights:
     ```bash
     docker scout cves <your-username>/sample-app:v1.0
     ```
   - Alternatively, if available, run:
     ```bash
     docker scout quickview <your-username>/sample-app:v1.0
     ```
     to get a summarized view of the image’s security posture.
   - **Optional:** Save the output to a file for further analysis:
     ```bash
     docker scout cves <your-username>/sample-app:v1.0 > scout_report.txt
     ```

2. **Review and Interpret the Report:**  
   - Carefully review the output and focus on:
     - **List of CVEs:** Identify vulnerabilities along with their severity ratings (e.g., Critical, High, Medium, Low).
     - **Affected Layers/Dependencies:** Determine which image layers or dependencies are responsible for the vulnerabilities.
     - **Suggested Remediations:** Note any recommended fixes or mitigation strategies provided by Docker Scout.
   - **Comparison Step:** If possible, compare this report with previous builds to assess improvements or regressions in your image's security posture.
   - If Docker Scout is not available in your environment, document that fact and consider using an alternative vulnerability scanner (e.g., Trivy, Clair) for a comparative analysis.

3. **Document Your Findings:**  
   - In your `solution.md`, provide a detailed summary of your analysis:
     - List the identified vulnerabilities along with their severity levels.
     - Specify which layers or dependencies contributed to these vulnerabilities.
     - Outline any actionable recommendations or remediation steps.
     - Reflect on how these insights might influence your image optimization or overall security strategy.
   - **Optional:** Include screenshots or attach the saved report file (`scout_report.txt`) as evidence of your analysis.

---

### Task 10: Documentation and Critical Reflection
1. **Update `solution.md`:**  
   - List all the commands and steps you executed.
   - Provide explanations for each task and detail any improvements made (e.g., image optimization with multi-stage builds).
2. **Reflect on Docker’s Impact:**  
   - Write a brief reflection on the importance of Docker in modern software development, discussing its benefits and potential challenges.

---

## 📢 How to Submit

1. **Push Your Final Work:**  
   - Ensure that your complete project—including your `Dockerfile`, `docker-compose.yml`, `solution.md`, and any additional files (e.g., the Docker Scout report if saved)—is committed and pushed to your repository.  
   - Verify that all your changes are visible in your repository.

2. **Create a Pull Request (PR):**  
   - Open a PR from your working branch (e.g., `docker-challenge`) to the main repository.  
   - Use a clear and descriptive title, for example:  
     ```
     Week 5 Challenge - DevOps Batch 9: Docker Basics & Advanced Challenge
     ```
   - In the PR description, include the following details:
     - A brief summary of your approach and the tasks you completed.
     - A list of the key Docker commands used during the challenge.
     - Any insights or challenges you encountered (e.g., lessons learned from multi-stage builds or Docker Scout analysis).

3. **Share Your Experience on LinkedIn:**  
   - Write a LinkedIn post summarizing your Week 5 Docker challenge experience.  
   - In your post, include:
     - A brief description of the challenge and what you learned.
     - Screenshots, logs, or excerpts from your `solution.md` that highlight key steps or interesting findings (e.g., Docker Scout reports).
     - The hashtags: **#90DaysOfDevOps #Docker #DevOps**
     - Optionally, links to any blog posts or related GitHub repositories that further explain your journey.

---

## Additional Resources

- **[Docker Documentation](https://docs.docker.com/)**  
- **[Docker Hub](https://docs.docker.com/docker-hub/)**  
- **[Multi-stage Builds](https://docs.docker.com/develop/develop-images/multistage-build/)**  
- **[Docker Compose](https://docs.docker.com/compose/)**  
- **[Docker Scan (Vulnerability Scanning)](https://docs.docker.com/engine/scan/)**  
- **[Containerization vs. Virtualization](https://www.docker.com/resources/what-container)**

---

Happy coding and best of luck with this Docker challenge! Document your journey thoroughly in `solution.md` and refer to these resources for additional guidance.
