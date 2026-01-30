
---

# ⚡ Emergency On-Call Cheat Sheet – 1 Page

### 1️⃣ Pager Alert / Incident

* Identify service & severity
* Slack/PagerDuty channel

---

### 2️⃣ Quick System Check

* `top` → CPU spikes?
* `free -h` → memory pressure?
* `df -h` → disk full?
* `ss -tulpn` → connections?
* `curl -I <endpoint>` → service up?

---

### 3️⃣ Logs

* Linux: `journalctl -u <service> -n 50`
* App: `tail -n 50 /var/log/<service>.log`
* K8s: `kubectl logs <pod>`

**Check for errors/warnings** → next step

---

### 4️⃣ Common Containment Actions

| Service        | Quick Fix                                    |
| -------------- | -------------------------------------------- |
| nginx          | `nginx -t && systemctl reload nginx`         |
| Postgres/MySQL | terminate idle sessions, restart DB          |
| Redis          | `CONFIG SET maxmemory <size>` / LRU          |
| K8s Pod        | `kubectl scale deployment <name>` / redeploy |
| Traffic spike  | rate limit, enable caching                   |
| DNS            | restart resolver / CoreDNS                   |

---

### 5️⃣ K8s / Crashloop / OOM

* `kubectl get pods` → status
* `kubectl describe pod` → events
* Adjust memory limits → redeploy
* Scale down/up deployment if needed

---

### 6️⃣ Database / Cache Pressure

* Postgres: `SELECT count(*) FROM pg_stat_activity;`
* Redis: `INFO memory` → eviction?
* DB connection limits → terminate idle / use pooling

---

### 7️⃣ DNS / Network

* `dig <host>` → resolve?
* `ping <resolver>` → network?
* Restart DNS / fallback resolver

---

### 8️⃣ If Incident Persists

1. Deep debugging: `strace`, `tcpdump`, heap dumps
2. Temporary mitigation: scale, rate-limit, disable debug logs
3. Escalate to senior SRE / DBA / cloud provider

---

### ✅ Quick Tips

* Always check **CPU, memory, disk, network** first
* Logs give root cause hints
* Contain → stabilize → investigate → update runbook
* Update this cheat sheet if new failure patterns appear

---

This is literally a **“90-second mental map”** — glance, act, contain, escalate, done.

---

