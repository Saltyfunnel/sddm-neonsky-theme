# ~/sddm-neonsky-repo/install.sh
#!/bin/bash

THEME_DIR="/usr/share/sddm/themes/sddm-neonsky-theme"
THEME_NAME="sddm-neonsky-theme"
FONT_DIR="/usr/share/fonts/"
CONFIG_DIR="/etc/sddm.conf.d"
CONFIG_FILE="${CONFIG_DIR}/10-neonsky-theme.conf"

echo "--- Installing ${THEME_NAME} ---"

# --- 1. Install Dependencies (Arch Specific) ---
echo "Installing SDDM dependencies via pacman..."
sudo pacman -Syu --needed sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg || { echo "Error installing dependencies. Aborting."; exit 1; }

# --- 2. Copy Theme Files ---
echo "Copying theme files to ${THEME_DIR}..."
sudo mkdir -p "${THEME_DIR}"
sudo cp -r * "${THEME_DIR}/"

# --- 3. Copy Fonts ---
echo "Copying required fonts to ${FONT_DIR}..."
sudo cp -r "Fonts/"* "${FONT_DIR}"

# --- 4. Configure SDDM to Use Theme ---
echo "Configuring SDDM to use ${THEME_NAME}..."
sudo mkdir -p "${CONFIG_DIR}"
# Write the theme configuration to a high-priority file
echo -e "[Theme]\nCurrent=${THEME_NAME}" | sudo tee "${CONFIG_FILE}"

# Optional: Enable Virtual Keyboard
echo -e "[General]\nInputMethod=qtvirtualkeyboard" | sudo tee "${CONFIG_DIR}/virtualkbd.conf"

echo "Theme installed successfully!"
echo "You must now restart the sddm service to apply the changes:"
echo "sudo systemctl restart sddm.service"

# Grant execution permissions to the script
chmod +x install.sh