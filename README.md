[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)  
Transformez votre tablette pc (ex: Dell Venue, Microsoft Surface, ...) avec un linux en mode **kiosk pour Home Assistant** en un seul script !

Ce script configure un utilisateur dédié, installe Chromium en **mode plein écran**, et assure un **autologin automatique**.

---

## 🚀 Fonctionnalités

- Création automatique de l’utilisateur `kiosk`.
- Installation des paquets nécessaires : X11, Openbox, Chromium, Unclutter.
- Lancement de Chromium en **mode Kiosk** sur votre URL Home Assistant.
- Suppression du curseur et gestion de l’alimentation de l’écran.

---

## 💻 OS compatibles

- Ubuntu Desktop (20.04 et +)
- Debian Desktop (10 et +)
- Raspberry Pi OS Desktop
- Autres distributions **basées sur Debian/Ubuntu** avec `apt`

---

## 📝 Pré-requis

- Compte avec droits **sudo**.
- URL de votre Home Assistant (ex: `http://homeassistant.local:8123/lovelace/0`).

---

## ⚡ Installation

### 1️⃣ Cloner le dépôt

```bash
git clone https://github.com/Geekeurexe/homeassistant-kiosk.git
cd kiosk
````

### 2️⃣ Rendre le script exécutable

```bash
chmod +x install.sh
```

### 3️⃣ Lancer le script

```bash
./install.sh
```

* Entrez l’URL de votre Home Assistant lorsque demandé.
* L’utilisateur `kiosk` sera créé si nécessaire.
* Les paquets requis seront installés et Openbox configuré.

### 4️⃣ Redémarrer la machine

```bash
sudo reboot
```

* La session `kiosk` se lance automatiquement.
* Chromium ouvre votre Home Assistant en **plein écran**.

---

## 📸 Aperçu (Exemple)

![Chromium en Kiosk](images/kiosk_chromium.png)
*Chromium en mode kiosk sur ma page Home Assistant*

---

## 🔧 Personnalisation

* **URL de Home Assistant** :
  Modifier `/home/kiosk/.config/openbox/autostart` :

```bash
chromium-browser --kiosk --noerrdialogs --disable-translate <VOTRE_URL> &
```

* **Temps d’inactivité avant extinction** :
  Modifier les valeurs `xset dpms` dans le même fichier.

* **Désactiver le curseur** :
  Ajuster `unclutter -idle 0.1 -root &` selon vos besoins.

---

## ⚠️ Limitations

* Le script **ne crée pas Home Assistant** ; il se connecte à une instance existante.
* Fonctionne uniquement sur **X11**.
* Les distributions non basées sur Debian/Ubuntu peuvent nécessiter des adaptations.

---

## 📂 Structure du dépôt

```
KIOSK-Ha/
├─ install.sh           # Script
├─ README.md            # Ce fichier
├─ LICENSE              # Licence MIT
├─ images/              # Capture d'écran
    └─ kiosk.png
```

---

## 💡 Astuce

Pour ajouter des fonctionnalités supplémentaires (ex. alertes Home Assistant, reboot automatique), modifiez le fichier Openbox `autostart`.
Pour masquer les menus dans home assistant : https://github.com/maykar/kiosk-mode.

---

## 📝 Licence

MIT License – consultez le fichier [LICENSE](LICENSE)
