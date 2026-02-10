#!/bin/bash
#
echo 'BASH='$BASH

echo 'HOSTNAME='$HOSTNAME

echo 'SSH_CLIENT='$SSH_CLIENT

echo 'PWD='$PWD

echo 'HOME='$HOME

echo 'USER='$USER

echo 'SSH_CONNECTION='$SSH_CONNECTION


cat <<COMMENT
🔐 What this tells us
SSH_CONNECTION=<client_ip> <client_port> <server_ip> <server_port>
✔ You are connected via SSH
✔ From 71.194.37.152 → 172.31.28.117
59698 → Client (source) port , 🧠 Client ports are usually above 1024
✔ Using port 22 on the server
✔ Session is active and authenticated
COMMENT

: <<COMMENT
🔐 What this tells us
SSH_CONNECTION=<client_ip> <client_port> <server_ip> <server_port>
✔ You are connected via SSH
✔ From 71.194.37.152 → 172.31.28.117
59698 → Client (source) port , 🧠 Client ports are usually above 1024
✔ Using port 22 on the server
✔ Session is active and authenticated
COMMENT




