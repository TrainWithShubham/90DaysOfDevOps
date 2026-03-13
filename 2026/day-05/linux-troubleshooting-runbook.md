

## Target Service
ssh (OpenSSH Server)

## Environment
- Kernel: Linux 6.14.0-1018-aws (x86_64)
- OS: Ubuntu 24.04.3 LTS (Noble Numbat)
- System uptime low, clean boot state

## Filesystem Sanity Check
Commands:
- mkdir /tmp/runbook-demo
- cp /etc/hosts /tmp/runbook-demo/hosts-copy

Observations:
- Temporary directory created successfully
- File copy succeeded with normal permissions
- Filesystem is writable and healthy

## CPU & Memory
Commands:
- top- this provide the list fo processes
- free -h - this display the storage in human readable format

Observations:
- CPU is 99% idle, load average near zero
- No high CPU processes observed
- Memory usage is low with ~510MB available
- No swap usage or memory pressure

## Disk & IO
Commands:
- df -h- This display file system usage in 1000 powers
- du -sh /var/log

Observations:
- Root filesystem only 36% utilized
- /var/log size is ~35MB
- No disk space or IO concerns

## Network
Commands:
- ss -tulpn
- ping -c 3 localhost

Observations:
- sshd listening on port 22 (IPv4 and IPv6)
- Localhost connectivity is healthy
- No packet loss or latency issues

---

## Logs Reviewed
Commands:
- journalctl -u ssh -n 50
- tail -n 50 /var/log/auth.log

Observations:
- SSH service starts cleanly after reboot
- Successful key-based logins observed
- No authentication errors or service crashes
- Log entries appear normal and expected

---

## Quick Findings
- System resources are healthy
- SSH service is stable and responsive
- No indicators of CPU, memory, disk, or network issues
- Logs show normal operational behavior

---

## If This Worsens (Next Steps)
1. Restart ssh service gracefully using systemctl and monitor logs
2. Investigate failed login attempts and review firewall or security group rules