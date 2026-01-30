**ULTIMATE ON-CALL RUNBOOK**.

This will be **one-page, reusable, interview-ready, and production-grade**. It covers **everything we’ve drilled**: CPU, memory, disk, network, logs, nginx, DB, Redis, K8s, DNS, traffic spikes.

Here’s the master template in Markdown:

---

# 🏆 ULTIMATE ON-CALL RUNBOOK

## 🧩 Service / Process Target

* Service Name: `<fill>`
* Type: Web / API / DB / Cache / K8s
* Host / Namespace / Cluster: `<fill>`
* Contact / Slack Channel: `<fill>`

---

## 1️⃣ Environment Basics

```bash
uname -a
cat /etc/os-release
```

*Check kernel, OS version, architecture.*

---

## 2️⃣ Filesystem Sanity

```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```

*Ensure disk writable.*

```bash
df -h
du -sh /var/log/<service>
```

*Check disk usage and log growth.*

---

## 3️⃣ CPU / Memory Snapshot

```bash
top
ps -o pid,pcpu,pmem,comm -p <pid>
free -h
```

*Observe spikes, runaway processes.*

* K8s: `kubectl top pod <pod>`
* Redis: `redis-cli info memory`
* DB: `sudo -u postgres psql -c "SELECT count(*) FROM pg_stat_activity;"`

---

## 4️⃣ Disk / IO

```bash
iostat -xz 1 3
vmstat 1 5
```

*Check I/O wait, disk saturation.*

---

## 5️⃣ Network / Connectivity

```bash
ss -tulpn | grep <service>
curl -I <service-endpoint>
```

*K8s:* `kubectl exec <pod> -- curl -I http://backend`
*DNS:* `dig <host>`

---

## 6️⃣ Logs Reviewed

```bash
journalctl -u <service> -n 50
tail -n 50 /var/log/<service>.log
```

*K8s:* `kubectl logs <pod>`
*Redis / DB:* slow queries, eviction stats

---

## 7️⃣ Common Failure Patterns

| Symptom                  | Likely Cause               | Action                                       |
| ------------------------ | -------------------------- | -------------------------------------------- |
| CPU 90%+                 | Runaway process, container | Kill / restart / scale                       |
| Disk >90%                | Log spamming, DB bloat     | Truncate logs, rotate, investigate           |
| 502 / 500 errors         | Upstream failure           | Check logs, restart service, verify DB/cache |
| DB connection exhaustion | Max connections reached    | Terminate idle sessions, scale pool          |
| CrashLoopBackOff         | OOM / config error         | Increase limits, fix config, redeploy        |
| Cache meltdown           | Max memory reached         | Increase maxmemory, LRU, scale               |

---

## 8️⃣ Quick Containment Commands

* nginx: `nginx -t && systemctl reload nginx`
* Postgres: terminate idle sessions, `systemctl restart postgresql`
* Redis: `config set maxmemory <size>` + eviction policy
* K8s: scale deployment, inspect pods, `kubectl describe`
* DNS: restart resolver or CoreDNS

---

## 9️⃣ Observability Checks

* CPU / Memory / Disk: `top`, `free -h`, `df -h`, `iostat`
* Network: `ss -tulpn`, `curl`, `dig`
* Logs: `journalctl`, `kubectl logs`, `tail -n 50`
* Metrics: Prometheus / Grafana dashboards
* Alerts: PagerDuty / Slack channels

---

## 🔥 If This Worsens (Next Steps)

1. **Deep debugging**

   * strace / lsof / tcpdump
   * Heap dumps for OOM
   * Profiling slow queries / cache patterns

2. **Temporary mitigation**

   * Scale horizontally (pods, instances)
   * Rate limiting / circuit breakers
   * Disable debug logging / access logs

3. **Escalation**

   * Notify senior SRE / DBA
   * Consider rolling back recent deployment / config change
   * Engage upstream / cloud provider if needed

---

## ✅ Quick Notes / Lessons Learned

* Document root cause
* Update runbook if new failure pattern discovered
* Automate monitoring or alerts for this issue

---

This **single page runbook** now covers:

* CPU, memory, disk, network
* Logs for services, DB, cache, K8s
* nginx, Redis, Postgres/MySQL, Kubernetes, DNS
* Traffic spike handling / rate limiting
* CrashLoopBackOff, OOM kills
* Quick containment commands + escalation steps

---

