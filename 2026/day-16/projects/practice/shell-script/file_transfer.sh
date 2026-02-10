#!/bin/bash
: <<'COMMENT'
Copy my projects to my laptop
using my server public IP
COMMENT

PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

echo "Public IP:  $PUBLIC_IP"
echo "Private IP: $PRIVATE_IP"


