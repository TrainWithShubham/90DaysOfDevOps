/ (root) - The starting point of everything
/home - User home directories
/root - Root user's home directory
/etc - Configuration files
/var/log - Log files (very important for DevOps!)
/tmp - Temporary files
Additional Directories (Good to Know):

/bin - Essential command binaries
/usr/bin - User command binaries
/opt - Optional/third-party applications


-----------------
ubuntu@ip-172-31-46-16:~/practive-day07$ systemctl is-enabled nginx
enabled
ubuntu@ip-172-31-46-16:~/practive-day07$ journalctl -u nginx
Jan 31 04:53:06 ip-172-31-46-16 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Jan 31 04:53:06 ip-172-31-46-16 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Jan 31 06:12:19 ip-172-31-46-16 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Jan 31 06:36:06 ip-172-31-46-16 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Jan 31 06:36:06 ip-172-31-46-16 systemd[1]: nginx.service: Deactivated successfully.
Jan 31 06:36:06 ip-172-31-46-16 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
-- Boot cf21a7b824094ab89b67f0c197f9f202 --
Feb 03 12:17:53 ip-172-31-46-16 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:17:53 ip-172-31-46-16 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Feb 03 12:20:39 ip-172-31-46-16 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:20:40 ip-172-31-46-16 systemd[1]: nginx.service: Deactivated successfully.
Feb 03 12:20:40 ip-172-31-46-16 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
-- Boot 48e6240148074712bfe205b9953afc68 --
Feb 03 12:21:50 ip-172-31-46-16 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:21:50 ip-172-31-46-16 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: nginx.service: Deactivated successfully.
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
ubuntu@ip-172-31-46-16:~/practive-day07$ sudo systemctl status nginx
○ nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: inactive (dead) since Tue 2026-02-03 12:38:06 UTC; 1min 19s ago
   Duration: 16min 16.219s
       Docs: man:nginx(8)
    Process: 1832 ExecStop=/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid (code=exited, status=0/SUCCESS)
   Main PID: 557 (code=exited, status=0/SUCCESS)
        CPU: 31ms

Feb 03 12:21:50 ip-172-31-46-16 systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:21:50 ip-172-31-46-16 systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: nginx.service: Deactivated successfully.
Feb 03 12:38:06 ip-172-31-46-16 systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
