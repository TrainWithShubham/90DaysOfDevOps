# Day XX – Docker Image Security Scanning (Trivy)

## Task
Docker images can contain **security vulnerabilities** because they are built on top of base operating system images.

Even if our application code is secure, the **base image packages may contain known CVEs (Common Vulnerabilities and Exposures).**

So in real CI/CD pipelines, we scan images before deployment.

Today we added **Trivy vulnerability scanning** to the pipeline.

---

# What is Trivy?

Trivy is a **container security scanner**.

It scans Docker images for:

• OS package vulnerabilities  
• Library vulnerabilities  
• Misconfigurations  
• Secrets  

Trivy compares packages inside the image with the **CVE database** and reports vulnerabilities.

---

# Pipeline Step Added

We added this step **after Docker build and before deploy**.

```yaml
- name: Scan Docker Image for Vulnerabilities
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'your-username/your-app:latest'
    format: 'table'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'
```

---

# What Each Parameter Means

### image-ref
Specifies which Docker image should be scanned.

Example:

```
your-username/your-app:latest
```

---

### format: table

Shows vulnerabilities in a **readable table format** inside GitHub Actions logs.

---

### exit-code: 1

This is important.

If **CRITICAL or HIGH vulnerabilities are detected**, the pipeline will:

• Fail the job  
• Stop deployment  

This prevents insecure images from reaching production.

---

### severity

```
CRITICAL,HIGH
```

This means only **high-risk vulnerabilities will fail the pipeline**.

Low or Medium vulnerabilities will still be reported but will not fail the pipeline.

---

# Scan Result

The pipeline **FAILED**.

Reason: Trivy detected vulnerabilities in the base image packages.

---

# Vulnerabilities Found

CVE detected:

```
CVE-2026-0861
```

Affected packages:

```
libc-bin
libc6
```

These are **core Linux system libraries**.

---

# Base Image Used

```
python:3.13-slim
```

This image is based on **Debian Linux**.

The vulnerability exists in the **Debian packages**, not in Python itself.

So the issue is from the **operating system layer of the Docker image**.

---

# Why This Happens

Docker images have multiple layers:

Application Code  
Python Runtime  
Linux Packages  
Base OS

Even if the application is secure, vulnerabilities may exist in **OS packages**.

Trivy scans all layers and reports issues.

---

# Real World Practice

In production pipelines teams usually:

• Scan Docker images before pushing to registry  
• Fail builds for critical vulnerabilities  
• Use minimal base images  
• Regularly update base images  

Example safer base images:

```
python:3.13-alpine
distroless
scratch
```

These contain fewer packages and therefore fewer vulnerabilities.

---

# Where to See Scan Output

GitHub Actions → Workflow run → Job logs

You will see a **vulnerability table** listing:

• Package name  
• Installed version  
• Fixed version  
• Severity  
• CVE ID  

---

# Screenshot Area

Add screenshots here:

1️⃣ GitHub Actions workflow run  



2️⃣ Trivy vulnerability scan output  
3️⃣ Table showing CVE details  
4️⃣ Pipeline failure status

---

# Key Learning

Security scanning should be part of every CI/CD pipeline.

It helps ensure:

• Secure Docker images  
• Vulnerabilities are detected early  
• Production environments remain protected
