# Fix WebHID connection for Keychron Q5 HE on Arch Linux (Chromium)

This is a minimal, step-by-step guide for the exact fix that worked.

Notes:
- Verified on Arch Linux (Omnarchy) with Chromium.
- Keyboard model: Keychron Q5 HE (USB IDs: `3434:0b50`).
- Replace IDs if your device differs (run `lsusb` to check).

## 1) Enable Web Platform features in Chromium
- Go to: `chrome://flags/#enable-experimental-web-platform-features`
- Set to: Enabled
- Relaunch Chromium

## 2) Add udev rules for the Q5 HE
Create a rules file with your device’s vendor/product IDs (this guide uses Q5 HE: `3434:0b50`):

```bash
sudo tee /etc/udev/rules.d/50-keychron-q5-he.rules >/dev/null <<'EOF'
# Keychron Q5 HE (WebHID)
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0b50", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
EOF
```

Apply the rules and replug:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
# Unplug and replug the keyboard USB cable
```

## 3) Connect in the Keychron web tool
- Use Chromium (not Firefox).
- Keyboard in wired USB mode.
- Open the Keychron web configurator/launcher, click Connect, select the device.

If your model is different:
- Find IDs with `lsusb` (format `vvvv:pppp`).
- Replace `3434` (vendor) and `0b50` (product) in the udev rule accordingly.