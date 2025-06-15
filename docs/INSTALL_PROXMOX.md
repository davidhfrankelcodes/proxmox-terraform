# Installing Proxmox VE

This guide covers the basic installation of Proxmox Virtual Environment (VE).

## Prerequisites
- A dedicated machine for Proxmox
- At least 8GB RAM (16GB+ recommended)
- 64-bit CPU with virtualization support (Intel VT-x/AMD-V)
- Network interface card
- USB drive (min 8GB) for installation media

## Installation Steps

1. **Download Proxmox VE ISO**
   - Visit [proxmox.com/downloads](https://www.proxmox.com/downloads)
   - Download the latest Proxmox VE ISO installer

2. **Create Installation Media**
   - Write the ISO to a USB drive using:
     - Rufus (Windows)
     - Etcher (Cross-platform)
     - dd command (Linux)

3. **Boot and Install**
   ```bash
   # Boot from USB
   1. Insert USB and boot from it
   2. Select "Install Proxmox VE"
   3. Accept EULA
   4. Select target hard disk
   5. Configure location and timezone
   6. Set root password and email
   7. Configure network settings
   ```

4. **First Boot**
   - Access web interface: https://your-ip:8006
   - Login with root credentials
   - Default username: root

5. **Post-Installation**
   ```bash
   # Update system
   apt update
   apt upgrade

   # Remove subscription notice (optional)
   sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
   systemctl restart pveproxy.service
   ```

## Troubleshooting
- Ensure BIOS/UEFI settings have virtualization enabled
- Check network configuration if web UI is inaccessible
- Verify hardware compatibility at [Proxmox Hardware Requirements](https://www.proxmox.com/en/proxmox-ve/requirements)
