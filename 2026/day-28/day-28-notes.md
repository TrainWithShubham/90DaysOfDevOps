# Day 28 - Revision and Self-Assessment

## Task 2 & 3: Quick-Fire Technical Review
1. **`chmod 755 script.sh`:** Grants Read/Write/Execute permissions (7) to the owner, and Read/Execute permissions (5) to both the group and other users.
2. **Process vs Service:** A process is any program currently executing on the system. A service (daemon) is a persistent background process specifically managed by the system (like `systemd`) that typically starts on boot.
3. **Port Scanning:** To find which process is using port 8080, use network statistic tools: `sudo ss -tulpn | grep 8080` or `sudo netstat -tulpn | grep 8080`.
4. **`set -euo pipefail`:** A fail-fast mechanism in Bash. It forces the script to immediately exit if any command fails (`-e`), if an undeclared variable is used (`-u`), or if a piped command fails (`-o pipefail`), preventing catastrophic cascading errors.
5. **Reset vs Revert:** `git reset --hard` completely erases the commit from history and deletes the files from the disk. `git revert` keeps the history intact but creates a brand new commit that safely undoes the previous changes.
6. **Branching Strategy:** For a fast-moving team of 5 developers, Trunk-Based Development or GitHub Flow (single main branch with short-lived feature branches) is optimal.
7. **Git Stash:** A temporary clipboard for uncommitted changes. Used when you need to switch branches (e.g., for an urgent hotfix) but your current working directory is dirty and not ready to be committed.
8. **Crontab Scheduling:** To run a script every day at 3 AM, the cron syntax is: `0 3 * * * /path/to/script.sh`.
9. **Fetch vs Pull:** `git fetch` safely downloads remote updates to the local database without touching working files. `git pull` fetches the data and aggressively merges it into the active working directory.
10. **LVM (Logical Volume Management):** Unlike standard hard drive partitions which have fixed, rigid sizes, LVM pools physical drives together, allowing you to dynamically resize, grow, and manage volumes on the fly without server downtime.

## Task 5: Teach It Back - DNS
**Concept:** Domain Name System (DNS)
**Explanation:** DNS operates like a massive Key-Value dictionary for the internet. Humans use readable domain names (google.com), while computers communicate using IP addresses (numbers). When you type a URL, your local DNS checks its cache to see if it already knows the IP. If it doesn't, it sends a request up the chain to Root, TLD, and SLD servers until it finds the matching IP, returns it to your browser, and caches it to make the next visit faster.