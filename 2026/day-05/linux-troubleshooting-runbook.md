# Linux Troubleshooting Runbook – Day 05

## Target service / process

* **Service:** `sshd` (OpenSSH Daemon) *
* **Purpose:** Remote access to the system *
* **Why chosen:** Critical service, always running, clear logs *

---

## Environment basics

```bash 
uname -a
```

**Observed:** Linux kernel 5.x, x86_64. Confirms kernel version and architecture.

```bash
cat /etc/os-release
```

**Observed:** Ubuntu 22.04 LTS. Confirms distro and release for package/log locations.

---

## Filesystem sanity check

```bash
mkdir /tmp/runbook-demo
```

**Observed:** Directory created successfully — filesystem is writable.

```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo
```

**Observed:** File copied correctly, permissions look normal. No disk or permission issues.

---

## Snapshot: CPU & Memory

```bash
ps -o pid,pcpu,pmem,comm -C sshd
```

**Observed:** sshd processes using <1% CPU and minimal memory. No abnormal usage.

```bash
free -h
```

**Observed:** ~60% memory available, no swap pressure. Memory not constrained.

---

## Snapshot: Disk & IO

```bash
df -h
```

**Observed:** Root filesystem at ~45% usage. Plenty of free disk space.

```bash
du -sh /var/log
```

**Observed:** /var/log ~250MB. Logs not consuming excessive disk.

---

## Snapshot: Network

```bash
ss -tulpn | grep sshd
```

**Observed:** sshd listening on port 22 (IPv4 and IPv6). Service is bound correctly.

```bash
curl -I localhost
```

**Observed:** Connection succeeds (HTTP headers returned). Network stack responsive.

---

## Logs reviewed

```bash
journalctl -u ssh -n 50
```

**Observed:** Normal startup messages, successful login attempts, no errors.

```bash
tail -n 50 /var/log/auth.log
```

**Observed:** Recent successful SSH logins, no failed-auth storms or warnings.

---

## Quick findings

* sshd is healthy and responsive
* No CPU, memory, or disk pressure
* Network port listening as expected
* Logs show normal operational behavior
* No immediate remediation required

---

## If this worsens (next steps)

1. **Restart strategy**

   ```bash
   systemctl restart ssh
   systemctl status ssh
   ```

   Check for restart failures or dependency issues.

2. **Increase log verbosity**

   * Temporarily increase `LogLevel VERBOSE` in `/etc/ssh/sshd_config`
   * Reload config and monitor logs for authentication or connection errors

3. **Deep inspection**

   * Attach `strace -p <pid>` if sshd is hanging
   * Capture network traffic with `tcpdump` to identify connection issues.

---









