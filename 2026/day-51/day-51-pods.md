<img width="1816" height="337" alt="image" src="https://github.com/user-attachments/assets/9695a18f-f9a2-4a7b-9d0d-c6eb680b4e28" /><img width="1811" height="868" alt="image" src="https://github.com/user-attachments/assets/1e1e7101-f10c-4d62-973e-9d0613df83bb" /># Day 51 – Kubernetes Manifests and Your First Pods

## Task 1: Create Your First Pod (Nginx)
<img width="1815" height="632" alt="image" src="https://github.com/user-attachments/assets/88ae0850-0b57-4229-829d-311540a3245c" />
<img width="1802" height="855" alt="image" src="https://github.com/user-attachments/assets/f1aaa5a9-6c4b-4a18-927f-63d72f2ab1a4" />
<img width="1809" height="840" alt="image" src="https://github.com/user-attachments/assets/b5d51465-3941-43cf-8649-0207c97cd705" />
<img width="1529" height="858" alt="image" src="https://github.com/user-attachments/assets/a261a386-5a49-4d91-99fd-1d0a2f9a4167" />
<img width="1765" height="891" alt="image" src="https://github.com/user-attachments/assets/7fdc0c35-f4cd-451d-bed0-f64b6223acb3" />
<img width="1637" height="454" alt="image" src="https://github.com/user-attachments/assets/4f081f84-7dc8-4d95-9e32-3e578b424e3d" />

## Task 2: Create a Custom Pod (BusyBox)


<img width="1662" height="634" alt="image" src="https://github.com/user-attachments/assets/6160ab5c-e143-434d-9290-db5d95eccbb5" />
<img width="1566" height="634" alt="image" src="https://github.com/user-attachments/assets/7103f82b-888b-44ed-9da2-5c72cf64de56" />  
Notice the command field — BusyBox does not run a long-lived server like Nginx. Without a command that keeps it running, the container would exit immediately and the pod would go into CrashLoopBackOff.

<img width="1330" height="144" alt="image" src="https://github.com/user-attachments/assets/fb677ac1-5624-447d-bb81-e55f912a2177" />


<img width="1688" height="465" alt="image" src="https://github.com/user-attachments/assets/e19e4741-42dd-4ff8-880c-cbad7250d989" />  
Above picture i have mentioned the CrashloopBackOff, its happening due to error and then exisiting so then its came to crashloopbackoff

### Task 3: Imperative vs Declarative
You have been using the declarative approach (writing YAML, then `kubectl apply`). Kubernetes also supports imperative commands:

```bash
# Create a pod without a YAML file
kubectl run redis-pod --image=redis:latest

# Check it
kubectl get pods
```

Now extract the YAML that Kubernetes generated:
```bash
kubectl get pod redis-pod -o yaml
```

Compare this output with your hand-written manifests. Notice how much extra metadata Kubernetes adds automatically (status, timestamps, uid, resource version).

You can also use dry-run to generate YAML without creating anything:
```bash
kubectl run test-pod --image=nginx --dry-run=client -o yaml
```

This is a powerful trick — use it to quickly scaffold a manifest, then customize it.

**Verify:** Save the dry-run output to a file and compare its structure with your nginx-pod.yaml. What fields are the same? What is different?

---



<img width="1819" height="864" alt="image" src="https://github.com/user-attachments/assets/b45607ce-7670-4380-b015-585ea48c2bf1" />
<img width="1625" height="853" alt="image" src="https://github.com/user-attachments/assets/3a2f995b-fc9c-4a23-ac2c-8bd2bc0fd688" />
<img width="1284" height="895" alt="image" src="https://github.com/user-attachments/assets/90f1e960-97a1-4e93-a48d-60886b2a930f" />
<img width="1652" height="855" alt="image" src="https://github.com/user-attachments/assets/29ffb517-7c51-4d3c-bd7d-68cc323d29ed" />
<img width="1811" height="868" alt="image" src="https://github.com/user-attachments/assets/a9a37493-9da5-4d08-91ef-5f336922dc59" />

So My handwritten manifest file has to less compare to auto writing manifest file:
Extra are: 
    creationTimestamp,generation,run,resourceVersion,uid,imagePullPolicy,resources,terminationMessagePath,terminationMessagePolicy,volumeMounts,readOnly,dnsPolicy,enableServiceLinks,nodeName,preemptionPolicy,
    priority,restartPolicy, schedulerName, securityContext and many more



## Task 4: Validate Before Applying


<img width="1816" height="337" alt="image" src="https://github.com/user-attachments/assets/c11dec80-33c2-49d7-9283-c50c43c6e514" />

When use kubectl apply -f nginx-pod.yaml --dry-run=server that time give the error but in --dry-run=client not given any error.
Once i gave different name from image its gave unknown field error.
And once i deleted the filed images so that time gave image field not found error.

## Task 5: Pod Labels and Filtering


<img width="1809" height="772" alt="image" src="https://github.com/user-attachments/assets/37e77670-4859-4e38-90e6-220802febaf2" />
<img width="1825" height="785" alt="image" src="https://github.com/user-attachments/assets/cf5b5e45-ce6f-4ff1-bf99-c0686492c05f" />  
Doing  a manifest for a third pod with at least 3 labels (app, environment, team). Apply it and practice filtering.


<img width="1801" height="496" alt="image" src="https://github.com/user-attachments/assets/3c3869c6-6c45-4abf-baf6-adacc6b65742" />


## Task 6: Clean Up

All The Pods



## What happens when you delete a standalone Pod?

1.kubectl → API Server  
- Sends delete request  
2.API Server    
- Marks Pod as Terminating
- Updates state in etcd  
3. kubelet (on that node)  
- Sees Pod marked for deletion
- Starts shutdown process  
4. Graceful termination  
- Sends SIGTERM to containers
- Waits (default: 30 seconds)  
5. Containers stop  
- If not stopped → SIGKILL
- Pod removed completely  
6. Deleted from etcd  
- Gone from cluste  




    













