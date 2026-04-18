Task 1: Install the Metrics Server
- Check if it is already running: kubectl get pods -n kube-system | grep metrics-server
- If not, install it:
  - Minikube: minikube addons enable metrics-server
  - Kind/kubeadm: apply the official manifest from the metrics-server GitHub releases
- On local clusters, you may need the --kubelet-insecure-tls flag (never in production)
- Wait 60 seconds, then verify: kubectl top nodes and kubectl top pods -A
  <img width="1900" height="918" alt="image" src="https://github.com/user-attachments/assets/4e537eaf-205c-4d41-a51d-e1f477309bec" />


Task 2: Explore kubectl top
- Run kubectl top nodes, kubectl top pods -A, kubectl top pods -A --sort-by=cpu
- kubectl top shows real-time usage, not requests or limits — these are different things
- Data comes from the Metrics Server, which polls kubelets every 15 seconds
- Verify: Which pod is using the most CPU right now?
  <img width="1287" height="643" alt="image" src="https://github.com/user-attachments/assets/21eecfe6-de05-4eef-949e-790347302efa" />


Task 3: Create a Deployment with CPU Requests
- Write a Deployment manifest using the registry.k8s.io/hpa-example image (a CPU-intensive PHP-Apache server)
- Set resources.requests.cpu: 200m — HPA needs this to calculate utilization percentages
- Expose it as a Service: kubectl expose deployment php-apache --port=80
- Without CPU requests, HPA cannot work — this is the most common HPA setup mistake.
- Verify: What is the current CPU usage of the Pod?
  <img width="1330" height="258" alt="image" src="https://github.com/user-attachments/assets/7c129355-04f9-4a99-98b4-9c4a914edbf2" />


Task 4: Create an HPA (Imperative)
- Run: kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
- Check: kubectl get hpa and kubectl describe hpa php-apache
- TARGETS may show <unknown> initially — wait 30 seconds for metrics to arrive
- This scales up when average CPU exceeds 50% of requests, and down when it drops below.
  <img width="1902" height="140" alt="image" src="https://github.com/user-attachments/assets/b2684e54-3d15-41b5-8a46-faa86eece967" />


Task 5: Generate Load and Watch Autoscaling
- Start a load generator: kubectl run load-generator --image=busybox:1.36 --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://php-apache; done"
- Watch HPA: kubectl get hpa php-apache --watch
- Over 1-3 minutes, CPU climbs above 50%, replicas increase, CPU stabilizes
- Stop the load: kubectl delete pod load-generator
- Scale-down is slow (5-minute stabilization window) — you do not need to wait
- Verify: How many replicas did HPA scale to under load?
  <img width="1173" height="367" alt="image" src="https://github.com/user-attachments/assets/79031a67-dd9a-449a-b7cf-5832c120adbd" />


Task 6: Create an HPA from YAML (Declarative)
- Delete the imperative HPA: kubectl delete hpa php-apache
- Write an HPA manifest using autoscaling/v2 API with CPU target at 50% utilization
- Add a behavior section to control scale-up speed (no stabilization) and scale-down speed (300 second window)
- Apply and verify with kubectl describe hpa
- autoscaling/v2 supports multiple metrics and fine-grained scaling behavior that the imperative command cannot configure.
  <img width="1111" height="671" alt="image" src="https://github.com/user-attachments/assets/33f5874d-e0bc-4b1c-b8e1-60c9adf8943c" />


Task 7: Clean Up
- Delete the HPA, Service, Deployment, and load-generator pod. Leave the Metrics Server installed.
  <img width="1186" height="183" alt="image" src="https://github.com/user-attachments/assets/22f679d8-2129-4f19-96e1-682ffb8fc0ea" />




  


