# Keychron WebHID Enabler for Arch Linux

---

![Bash](https://img.shields.io/badge/Bash-5.x-4EAA25?logo=gnubash&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=archlinux&logoColor=white)
![udev](https://img.shields.io/badge/udev-rules-555555?logo=linux&logoColor=white)
![WebHID](https://img.shields.io/badge/WebHID-API-4285F4?logo=googlechrome&logoColor=white)
![Chromium](https://img.shields.io/badge/Chromium-native-0F70E0?logo=googlechrome&logoColor=white)
![QMK](https://img.shields.io/badge/QMK-compatible-blue?logo=qmk&logoColor=white)
![VIA](https://img.shields.io/badge/VIA-compatible-9B59B6)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

---

This repository provides an automated script to enable WebHID support for multiple Keychron keyboards (QMK/VIA/Launcher compatible) on Arch Linux.

By default, Linux restricts user access to raw USB/HID interfaces. Because the [Keychron Launcher](https://launcher.keychron.com/) operates via the browser using the WebHID API, you must explicitly grant it permission to read and write to your keyboards' firmware.

## 1. Prerequisites

Before running the hardware configuration, you must enable WebHID support in your Chromium-based browser.

1. Open Chromium (ensure it is a native package, not a Flatpak/Snap, as sandboxing blocks raw USB access).
2. Navigate to: chrome://flags/#enable-experimental-web-platform-features
3. Set **Experimental Web Platform features** to **Enabled**.
4. Click **Relaunch** at the bottom of the browser.

## 2. Usage

This script scans your USB tree for any device containing the name "Keychron", extracts its unique Vendor ID (VID) and Product ID (PID), and automatically generates the necessary udev rules.

1. Ensure all your Keychron keyboards are connected via USB (Wired mode).
2. Run the script:
```./setup_keychron_webhid.sh```
3. Once the script finishes, **unplug and replug** your keyboards.

## 3. Connect via Keychron Launcher

1. Go to the [Keychron Launcher](https://launcher.keychron.com/) in Chromium.
2. Click **Connect**.
3. A browser prompt will appear showing your available Keychron devices. Select the one you want to configure and click **Connect**.

## Troubleshooting

* **Browser Cannot See Devices:** Double-check that you are not using a Flatpak version of Chromium/Brave. Flatpaks isolate the browser from the host's hardware interfaces. Use sudo pacman -S chromium to install the native version.
* **"Device In Use" Error:** Close any standalone VIA desktop applications, QMK toolboxes, or other browser tabs that might already have an active lock on the keyboard's HID interface.
* **No Devices Found by Script:** Ensure the physical toggle switch on the back of the keyboards is set to **Cable** and that you are using data-capable USB cables.
