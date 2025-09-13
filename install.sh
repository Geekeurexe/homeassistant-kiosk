#!/bin/bash
# ===========================================================
# KIOSK-Ha by Geexe
# ===========================================================

set -e

USER="kiosk"

echo "============================================"
echo "   Installation Kiosk Home Assistant"
echo "============================================"
read -p "Entrez l'URL Home Assistant (ex: http://homeassistant.local:8123/lovelace/0) : " HA_URL

if [ -z "$HA_URL" ]; then
  echo "URL Vide"
  exit 1
fi

echo "URL : $HA_URL"

# 1. Créer l'utilisateur kiosk si besoin
if id "$USER" &>/dev/null; then
  echo "ℹL'utilisateur $USER existe déjà."
else
  echo "Création de l'utilisateur $USER..."
  sudo adduser --disabled-password --gecos "" $USER
fi

# 2. Installer les paquets nécessaires
echo "Installation des paquets requis..."
sudo apt update
sudo apt install -y --no-install-recommends \
  xserver-xorg x11-xserver-utils xinit openbox chromium-browser unclutter

# 3. Configurer Openbox autostart
echo "Configuration d'openbox..."
sudo -u $USER mkdir -p /home/$USER/.config/openbox

cat <<EOF | sudo -u $USER tee /home/$USER/.config/openbox/autostart
chromium-browser --kiosk --noerrdialogs --disable-translate $HA_URL &

unclutter -idle 0.1 -root &

xset s 30
xset +dpms
xset dpms 30 30 30
EOF

echo "Configuration du lancement automatique de X11 Server..."
cat <<'EOF' | sudo -u $USER tee -a /home/$USER/.bash_profile

if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec startx
fi
EOF

echo "Configuration de l'autologin systemd..."
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
cat <<EOF | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I \$TERM
EOF

sudo systemctl daemon-reexec

echo "Installation terminée !"
echo "➡️ Redémarre la machine avec : sudo reboot"
echo "Au démarrage, la session $USER s'ouvrira automatiquement"
echo "et Chromium affichera $HA_URL en plein écran."
echo "L'écran s'éteindra après 30 secondes d'inactivité."
