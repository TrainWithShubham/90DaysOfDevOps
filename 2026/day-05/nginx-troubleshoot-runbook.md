# 🔥 NGINX TROUBLESHOOTING DRILL (FULL EXECUTION)

## Target service / process

* **Service:** nginx
* **Role:** Web server / reverse proxy
* **Incident type:** 502 errors, high CPU, disk filling

---

## 🚨 Simulated Failure (Intentional Break)

**What broke:**

* Debug logging enabled
* Backend upstream stopped

```nginx
error_log /var/log/nginx/error.log debug;
```

Upstream app is **down**.

---

## Environment basics

```bash
uname -a
```

**Observed:** Linux 5.x kernel, x86_64.

```bash
cat /etc/os-release
```

**Observed:** Ubuntu 22.04 LTS.

---

## Filesystem sanity

```bash
mkdir /tmp/runbook-demo
```

**Observed:** Directory created successfully.

```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```

**Observed:** File copied; filesystem writable.

---

## Snapshot: CPU & Memory

```bash
top
```

```
PID   USER   %CPU  %MEM  COMMAND
3112  www    168.4  1.3   nginx
```

**Observed:** nginx worker saturating CPU.

```bash
free -h
```

**Observed:** Memory OK, no swap pressure.

---

## Snapshot: Disk & IO

```bash
df -h
```

```
/dev/sda1   40G   38G   2G  95% /
```

**Observed:** Disk nearing critical.

```bash
du -sh /var/log/nginx
```

```
14G /var/log/nginx
```

**Observed:** nginx logs consuming most disk.

---

## Snapshot: Network

```bash
ss -tulpn | grep nginx
```

```
LISTEN 0 511 0.0.0.0:80 users:(("nginx",pid=3112))
```

**Observed:** nginx listening correctly.

```bash
curl -I http://localhost
```

```
HTTP/1.1 502 Bad Gateway
```

**Observed:** Frontend reachable, backend failing.

---

## Logs reviewed

```bash
tail -n 50 /var/log/nginx/error.log
```

```
connect() failed (111: Connection refused) while connecting to upstream
```

**Observed:** Upstream application down.

```bash
journalctl -u nginx -n 50
```

**Observed:** No crash loops; config still valid.

---

## Root cause

* Debug log level caused **log explosion**
* Disk pressure + CPU overhead
* Backend service unavailable → 502s

---

## Containment & Fix

```bash
sed -i 's/debug;/warn;/' /etc/nginx/nginx.conf
```

```bash
nginx -t
```

**Observed:** Config OK.

```bash
systemctl reload nginx
```

```bash
truncate -s 0 /var/log/nginx/error.log
```

```bash
systemctl restart backend-app
```

* ✅ CPU normal
* ✅ Disk stabilized
* ✅ HTTP 200 restored

---

## Quick findings

* nginx was running but unhealthy
* Log level misconfiguration amplified impact
* Reload sufficient; full restart unnecessary
* Disk pressure directly affected service health

---

## If this worsens (next steps)

1. **Disable access logs temporarily**

   ```nginx
   access_log off;
   ```

2. **Add rate limiting**

   ```nginx
   limit_req zone=req_limit burst=10 nodelay;
   ```

3. **Deep debugging**

   ```bash
   strace -p <nginx-worker-pid>
   tcpdump -i eth0 port 80
   ```

---

## ✅ Final Result

You now have:

* A **realistic nginx incident**
* A **repeatable troubleshooting flow**
* A **production-grade runbook**
* Exactly what interviewers expect when they ask:

  > “How do you troubleshoot a failing service?”

---
