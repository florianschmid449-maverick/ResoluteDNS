#!/bin/bash

# Ensure the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)."
   exit 1
fi

CONF_FILE="/etc/systemd/resolved.conf"
BACKUP_FILE="/etc/systemd/resolved.conf.bak"

echo "--- Optimizing systemd-resolved for Fedora ---"

# 1. Create a backup
cp "$CONF_FILE" "$BACKUP_FILE"
echo "[+] Backup created at $BACKUP_FILE"

# 2. Update the [Resolve] section
# This uses sed to find the [Resolve] header and append our optimized settings
# while removing existing (and potentially commented out) conflicting lines.
sed -i '/^DNS=/d' "$CONF_FILE"
sed -i '/^Cache=/d' "$CONF_FILE"
sed -i '/^CacheSize=/d' "$CONF_FILE"
sed -i '/^StaleResubmit=/d' "$CONF_FILE"

# Append the new settings under the [Resolve] header
sed -i '/\[Resolve\]/a DNS=1.1.1.1 8.8.8.8\nCache=yes\nCacheSize=10000\nStaleResubmit=yes' "$CONF_FILE"

echo "[+] Configuration updated."

# 3. Restart the service
echo "[+] Restarting systemd-resolved..."
systemctl restart systemd-resolved

# 4. Verify results
echo "--- Current Statistics ---"
resolvectl statistics | grep -E "CacheSize|Current Cache Size"

echo "-----------------------------------------------"
echo "Success! Your DNS cache limit is now 10,000."
