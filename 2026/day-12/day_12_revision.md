# Day 12 – Breather & Revision (Days 01–11)

## Goal
Consolidate fundamentals from Days 01–11 and lock in muscle memory.

---

## Mindset & Plan (Day 01 Revisit)
- Original goal: Build strong Linux/DevOps foundations with hands-on practice.
- What’s working:
  - Daily hands-on logs (processes, services, permissions) made concepts stick.
  - Writing mini runbooks clarified *why* commands are used, not just *how*.
- Tweaks:
  - Spend more time on **permissions & ownership edge cases** (chmod numbers, group collaboration).
  - Add a **5-minute daily incident drill** ("service down", "disk full", "permission denied").

---

## Processes & Services (Re-run)
Commands rerun today:
```bash
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head
systemctl status nginx
```
Observations:
- PID 1 is systemd → systemctl works as expected.
- nginx service is active and running; workers are idle (low CPU).
- Quick confirmation that `ps` gives snapshot, while `systemctl status` gives service health context.

---

## File Skills Practice (3 Quick Ops)
Commands practiced:
```bash
echo "Revision check" >> notes.txt
chmod 640 notes.txt
mkdir -p /tmp/day12-test && cp notes.txt /tmp/day12-test/
```
Notes:
- `>>` appends safely without overwriting.
- Numeric chmod (640) is faster and clearer than symbolic in incidents.
- Always verify with `ls -l` after permission or copy operations.

---

## Cheat Sheet Refresh (Day 03)
Top 5 commands I’d reach for first in an incident:
1. `top` – immediate CPU/memory visibility.
2. `ps aux` – full process snapshot when top is noisy.
3. `systemctl status <service>` – fastest service health check.
4. `journalctl -u <service> -n 20` – recent errors without digging through files.
5. `df -h` – rule out disk-full issues early.

---

## User / Group Sanity Check

```bash
sudo useradd -m testuser
sudo chown testuser:testuser /tmp/day12-test
ls -ld /tmp/day12-test
id testuser
```
Verification:
- Ownership updated correctly.
- `id` confirms UID/GID and group membership.
- Confirms safe order: create user → change ownership → verify.

---

## Mini Self-Check

### 1) Which 3 commands save me the most time right now, and why?
- `top` – instant visibility into system health.
- `systemctl status` – quick yes/no on service health + logs hint.
- `ls -l` – immediately explains 80% of permission-related issues.

### 2) How do I check if a service is healthy?
Commands run first:
```bash
systemctl status <service>
journalctl -u <service> -n 20
ps -ef | grep <service>
```

### 3) How do I safely change ownership and permissions?
Example:
```bash
sudo chown tokyo:developers /opt/dev-project
sudo chmod 775 /opt/dev-project
```
- Change ownership first.
- Then apply permissions.
- Verify with `ls -ld`.

### 4) What will I focus on in the next 3 days?
- Permissions & ownership edge cases (sticky bit, umask basics).
- Faster incident-style command selection.
- Writing shorter, cleaner troubleshooting notes.

---

## Key Takeaways
- Linux basics compound fast when reviewed intentionally.
- Verifying after every change (`ls -l`, `id`, `status`) prevents silent mistakes.
- Confidence now comes from *recognition*, not memorization.



