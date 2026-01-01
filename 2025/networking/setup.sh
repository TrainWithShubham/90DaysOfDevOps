#!/bin/bash

echo "Setting up Week 1 - Networking Challenge Environment..."

# Create directories
#mkdir -p examples blog assets

# Install networking tools
sudo apt update -y
sudo apt install -y net-tools curl dnsutils traceroute

echo "✅ Tools installed successfully!"
