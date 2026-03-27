# Day 54 – Kubernetes ConfigMaps and Secrets

## Overview
Applications need configuration like database URLs, API keys, feature flags, etc.
Hardcoding these into container images is not a good practice because every change requires rebuilding the image.

Kubernetes solves this using:
- ConfigMaps → for non-sensitive configuration
- Secrets → for sensitive data

---

# ConfigMaps

## What is a ConfigMap?
A ConfigMap stores non-sensitive configuration data in key-value format.

### Use Cases
- Application configs
- Environment variables
- Nginx / application config files

---

## Create ConfigMap from Literals

kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=APP_DEBUG=false \
  --from-literal=APP_PORT=8080

Verify:
kubectl describe configmap app-config
kubectl get configmap app-config -o yaml

Data is stored as plain text (no encoding, no encryption)

---

## Create ConfigMap from File

kubectl create configmap nginx-config \
  --from-file=default.conf=default.conf

Key Concept:
- File name → becomes key
- File content → becomes value

---

# Using ConfigMap in Pods

## Using Environment Variables

envFrom:
  - configMapRef:
      name: app-config

Injects all keys as environment variables

---

## Using Volume Mount

volumeMounts:
  - name: config-volume
    mountPath: /etc/config

volumes:
  - name: config-volume
    configMap:
      name: nginx-config

Each key becomes a file inside the container

---

## Env vs Volume Mount

Environment Variables:
- Simple values → Yes
- File-based config → No
- Auto update → No
- Requires restart → Yes

Volume Mount:
- Simple values → Yes
- File-based config → Yes
- Auto update → Yes
- Requires restart → No

---

# Secrets

## What is a Secret?
A Secret stores sensitive data like:
- Passwords
- API keys
- Tokens

---

## Create Secret

kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD=s3cureP@ssw0rd

---

## Inspect Secret

kubectl get secret db-credentials -o yaml

Values are base64 encoded

---

## Decode Secret

echo 'base64-value' | base64 --decode

Important:
Base64 = Encoding (not encryption)
Anyone with access can decode it

---

# Using Secret in Pod

## As Environment Variable

env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_USER

---

## As Volume

volumeMounts:
  - name: secret-volume
    mountPath: /etc/db-credentials
    readOnly: true

volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials

---

## Inside Container

ls /etc/db-credentials
cat /etc/db-credentials/DB_USER

Output is PLAINTEXT

---

## Secret Behavior

- In Kubernetes YAML → Base64
- Inside Pod → Plaintext

---

# ConfigMap Live Update

Steps:
1. Create ConfigMap
2. Mount as volume
3. Read file in loop
4. Update ConfigMap

kubectl patch configmap live-config \
  --type merge -p '{"data":{"message":"world"}}'

Result:
hello → world (without pod restart)

---

## Behavior Difference

- Volume Mount → Auto update
- Environment Variables → No update

---

# Why This Happens

- ConfigMap volume → updated dynamically by kubelet
- Env variables → fixed at container startup

Important:
Kubernetes updates the file
Application must re-read it

---

# Volume & VolumeMount Concept

volume = source of data
volumeMount = location inside container

---

## Data Flow

ConfigMap / Secret
        ↓
      Volume
        ↓
   volumeMount (path)
        ↓
   Container (file)
        ↓
   Application reads it

---

# Real-World Usage

- DB password → Env / Secret
- Nginx config → Volume
- SSL certificate → Volume
- Feature flags → Env

---

# Golden Rule

If app needs VALUE → use env
If app needs FILE → use volumeMount

---

# Interview Questions

Q1: ConfigMap vs Secret?
ConfigMap → non-sensitive data
Secret → sensitive data

Q2: Do ConfigMaps update automatically?
Yes (volume mount), No (env variables)

Q3: Is base64 encryption?
No, it is encoding

Q4: Why no restart needed for volume?
Kubelet updates mounted files dynamically

---

# Cleanup

kubectl delete pod <pod-name>
kubectl delete configmap <name>
kubectl delete secret <name>

---

# Summary

- ConfigMaps → store non-sensitive config
- Secrets → store sensitive data
- Env → for simple values (static)
- Volume → for files (dynamic)
- Base64 → encoding, not encryption
- Volume mounts auto-update, env does not

---

# Final Learning

Decouple configuration from application → core DevOps principle
