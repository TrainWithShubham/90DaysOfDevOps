**Check running processes**
--------'----------------

ps -ef | head

<img width="777" height="197" alt="Screenshot 2026-02-10 at 6 30 15 PM" src="https://github.com/user-attachments/assets/da3251fa-67a9-4c15-bfe5-035677df2764" />


systemctl status ssh
<img width="1660" height="502" alt="Screenshot 2026-02-10 at 6 32 01 PM" src="https://github.com/user-attachments/assets/8d9b8bcb-f257-4bce-8541-d92f51b7180e" />

**Log Checks**
--------------
journalctl -u ssh --no-pager | tail -n 10

tail -n 20 /var/log/syslog

<img width="1411" height="398" alt="Screenshot 2026-02-10 at 6 34 20 PM" src="https://github.com/user-attachments/assets/3b724069-3854-450d-9029-d2c22c3d6737" />


