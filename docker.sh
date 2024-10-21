#!/bin/sh

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Re-running with sudo..."
  sudo "$0" "$@"
  exit $?
fi

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done

# Add Docker's official GPG key:
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if [ ! -f /bin/docker-compose ]; then
  curl -fsSL https://raw.githubusercontent.com/prokopschield/scripts/master/docker-compose.sh -o /bin/docker-compose
  chmod +x /bin/docker-compose
fi
