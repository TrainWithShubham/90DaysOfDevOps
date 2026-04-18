Task 1: Resource Requests and Limits
- Write a Pod manifest with resources.requests (cpu: 100m, memory: 128Mi) and resources.limits (cpu: 250m, memory: 256Mi)
- Apply and inspect with kubectl describe pod — look for the Requests, Limits, and QoS Class sections
- Since requests and limits differ, the QoS class is Burstable. If equal, it would be Guaranteed. If missing, BestEffort.
- CPU is in millicores: 100m = 0.1 CPU. Memory is in mebibytes: 128Mi.
  <img width="1383" height="822" alt="image" src="https://github.com/user-attachments/assets/802950e3-4aed-450a-a46c-efef13c7c321" />


Task 2: OOMKilled — Exceeding Memory Limits
- Write a Pod manifest using the polinux/stress image with a memory limit of 100Mi
- Set the stress command to allocate 200M of memory: command: ["stress"] args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]
- Apply and watch — the container gets killed immediately
- CPU is throttled when over limit. Memory is killed — no mercy.
- Check kubectl describe pod for Reason: OOMKilled and Exit Code: 137 (128 + SIGKILL).
  <img width="1205" height="522" alt="image" src="https://github.com/user-attachments/assets/be9465bf-a951-4acd-96d5-b7a782cec327" />


Task 3: Pending Pod — Requesting Too Much
- Write a Pod manifest requesting cpu: 100 and memory: 128Gi
- Apply and check — STATUS stays Pending forever
- Run kubectl describe pod and read the Events — the scheduler says exactly why: insufficient resources
- Verify: What event message does the scheduler produce?
  <img width="1061" height="236" alt="image" src="https://github.com/user-attachments/assets/1251a12f-86b5-4415-9cd6-1a27ee69b0dd" />


Task 4: Liveness Probe
- Write a Pod manifest with a busybox container that creates /tmp/healthy on startup, then deletes it after 30 seconds
- Add a liveness probe using exec that runs cat /tmp/healthy, with periodSeconds: 5 and failureThreshold: 3
- After the file is deleted, 3 consecutive failures trigger a restart. Watch with kubectl get pod -w
- Verify: How many times has the container restarted?
  <img width="1071" height="402" alt="image" src="https://github.com/user-attachments/assets/f461f301-3ef0-4a0b-a3a1-a767414c428f" />


Task 5: Readiness Probe
- Write a Pod manifest with nginx and a readinessProbe using httpGet on path / port 80
- Expose it as a Service: kubectl expose pod <name> --port=80 --name=readiness-svc
- Check kubectl get endpoints readiness-svc — the Pod IP is listed
- Break the probe: kubectl exec <pod> -- rm /usr/share/nginx/html/index.html
- Wait 15 seconds — Pod shows 0/1 READY, endpoints are empty, but the container is NOT restarted
- Verify: When readiness failed, was the container restarted?
  <img width="1413" height="422" alt="image" src="https://github.com/user-attachments/assets/777650cc-7b9e-4606-ad71-b841da3ff7fe" />


Task 6: Startup Probe
- Write a Pod manifest where the container takes 20 seconds to start (e.g., sleep 20 && touch /tmp/started)
- Add a startupProbe checking for /tmp/started with periodSeconds: 5 and failureThreshold: 12 (60 second budget)
- Add a livenessProbe that checks the same file — it only kicks in after startup succeeds
- Verify: What would happen if failureThreshold were 2 instead of 12?
  <img width="1186" height="352" alt="image" src="https://github.com/user-attachments/assets/b30c9fd6-2cab-4d5f-af3c-b14581de44ad" />







