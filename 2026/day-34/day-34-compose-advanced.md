# Day 34 – Docker Compose: Real-World Multi-Container Apps

---
## Task 1: Build Your Own App Stack
Done

---

## Task 2: depends_on & Healthchecks

Done
---

## Task 3: Restart Policies
| Policy       | Behavior                                                 |
| ------------ | -------------------------------------------------------- |
| `always`     | Restarts no matter what (even manual stop in some cases) |
| `on-failure` | Only restarts if exit code ≠ 0                           |
| `no`         | Never restart                                            |

* When to use:
- always
- Databases
- Critical infrastructure
- Long-running services
- on-failure
- Batch jobs
- Workers (retry on crash only)

---

## Task 4: Custom Dockerfiles in Compose
Done

---

## Task 5: Named Networks & Volumes
* Why:

- Predictable service discovery
- Isolation from other stacks

* Why:

- Persistent DB storage
- Survives container deletion

---

## Task 6: Scaling (Bonus)

Command:

```
docker compose up --scale flask_app=3
```

What happens:
3 containers start:
flask_app_1, flask_app_2, flask_app_3
BUT:
Problem:

```
ports:
  - "5000:5000"
```

Only one container can bind to port 5000 on the host

Result:
Scaling fails OR only one instance is accessible
Why scaling breaks with port mapping

Because:

- Port binding is host-level

You cannot map:

host:5000 → multiple containers
Correct pattern (real-world):

Remove ports and use:

Reverse proxy (NGINX / Traefik)
Load balancer
Docker internal DNS

Example:
```
web:
  deploy:
    replicas: 3
```
And expose via:

NGINX upstream
Or Kubernetes service (in real production)
Summary of What You Built

You now have:

Multi-service containerized app
Proper startup sequencing (healthchecks + depends_on)
Restart resilience
Custom build pipeline
Persistent storage
Network isolation
Understanding of scaling limitations

---

![alt text](images/day34-task-1-dockerfile.png) ![alt text](images/day34-task-1.png) ![alt text](images/day34-task-2-docker-compose-build.png) ![alt text](images/day34-task-2-docker-compose.png) ![alt text](images/day34-task-2-docker-ps.png) ![alt text](images/day34-task-2.png) ![alt text](images/day34-task-3.png) ![alt text](images/day34-task-4-image.png) ![alt text](images/day34-task-4-on-failure-d.png) ![alt text](images/day34-task-4-on-failure.png) ![alt text](images/day34-task-4-restart-on-f.png) ![alt text](images/day34-task-4-restart-on-failure.png) ![alt text](images/day34-task-4-restart.png) ![alt text](images/day34-task-4.png) ![alt text](images/day34-task-6-1.png) ![alt text](images/day34-task-6-scale-up.png) ![alt text](images/day34-task-6.2.png) ![alt text](images/day34-task-6.3.png) ![alt text](images/day34-task-6.4.png) ![alt text](images/day34-task-6.png) ![alt text](images/day34-task6.5.png)

---