## Process commands

- ps aux

![alt text](image.png)

- top

![alt text](image-1.png)

## Service commands

- systemctl list-units
Lists all services present in the machine

![alt text](image-2.png)

- systemctl status sshd

![alt text](image-3.png)

## Log commands

- journalctl -u podman

![alt text](image-4.png)

- journalctl -n 5 -u podman
Displays the latest 5 lines of logs of a service

![alt text](image-5.png)

## Inspect one service - Podman

- systemctl list-units --state=running | grep podman
To check if podman is running

![alt text](image-6.png)

- systemctl status podman
This commands tells the exact status of podman

![alt text](image-7.png)

- journalctl -u podman
Displays detailed log

![alt text](image-8.png)
