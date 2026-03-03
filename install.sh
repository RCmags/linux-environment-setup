# Install script to setup an XFCE install


#------- base programs -------
#:: Tools
sudo apt install wget
sudo apt install htop
sudo apt install intel-gpu-tools
sudo apt install lm-sensors
sudo apt-get install thermald
sudo systemctl enable thermald

#:: TLP
sudo apt install tlp tlp-rdw
sudo systemctl enable --now tlp.service

#:: File tranfer
sudo apt install syncthing
systemctl --user start syncthing

#:: gui tools
sudo apt install vlc
sudo apt install kdiskmark
sudo apt install screengrab
sudo apt install gnome-system-monitor

# :: qt platform themes
# https://bbs.archlinux.org/viewtopic.php?id=259721
# https://askubuntu.com/questions/910012/how-can-i-get-qt5-applications-to-use-the-gtk-theme-in-ubuntu-17-04
# https://www.youtube.com/watch?v=yhbDy_i9X1w
sudo apt install qt5ct
sudo apt install qt6ct

#------------------------------

# Flatpak install
sudo apt install flatpak
#sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# ------ Flatpak apps -------
# https://flathub.org/en

# :: system
flatpak install flathub com.github.d4nj1.tlpui
flatpak install flathub it.mijorus.gearlever
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub io.github.giantpinkrobots.flatsweep

# :: design
flatpak install flathub org.freecad.FreeCAD
flatpak install flathub cc.arduino.IDE2
flatpak install flathub org.kde.krita
flatpak install flathub org.audacityteam.Audacity
flatpak install flathub com.jgraph.drawio.desktop
flatpak install flathub com.obsproject.Studio
flatpak install flathub org.kde.kdenlive

# :: games
flatpak install flathub org.DolphinEmu.dolphin-emu
flatpak install flathub net.pcsx2.PCSX2
flatpak install flathub org.ppsspp.PPSSPP

# :: work
flatpak install flathub org.texstudio.TeXstudio
flatpak install flathub org.freedesktop.Sdk.Extension.texlive
flatpak install flathub com.vscodium.codium
flatpak install flathub com.github.xournalpp.xournalpp
flatpak install flathub org.onlyoffice.desktopeditors

# :: helpers
flatpak install flathub com.github.jeromerobert.pdfarranger
flatpak install flathub io.github.alainm23.planify
flatpak install flathub com.rustdesk.RustDesk
flatpak install flathub net.mkiol.SpeechNote
#flatpak install flathub io.github.jonmagon.kdiskmark

# :: misc
flatpak install flathub io.freetubeapp.FreeTube
flatpak install flathub org.js.nuclear.Nuclear
flatpak install flathub io.github.davidoc26.wallpaper_selector

# :: chat
flatpak install flathub org.telegram.desktop
flatpak install flathub org.signal.Signal

# :: browsers
flatpak install flathub org.torproject.torbrowser-launcher

## ------ Apt -------

# SIGNAL:
# https://signal.org/download/#
# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
# 2. Add our repository to your list of repositories:
wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop


# waydroid installer
# https://github.com/1999AZZAR/use-waydroid-on-x11/tree/master


# waydroid script 
# https://github.com/casualsnek/waydroid_script


# miniconda
# https://www.anaconda.com/docs/getting-started/miniconda/install#linux-terminal-installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ~/Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc


# zoom
# https://zoom.us/download


# Virtual machine manager
# https://ubuntuhandbook.org/index.php/2024/12/kvm-qemu-virtual-machines-ubuntu/
sudo apt install qemu-system
sudo apt install virt-manager
sudo gpasswd --add $USER libvirt
sudo systemctl start libvirtd


# Ungoogled chromium
# https://github.com/ungoogled-software/ungoogled-chromium?tab=readme-ov-file#downloads
# https://itsfoss.gitlab.io/post/how-to-install-ungoogled-chromium-on-ubuntu-2404-2204-or-2004/
sudo add-apt-repository ppa:xtradeb/apps
sudo apt update
sudo apt install ungoogled-chromium


# Cortile
# https://github.com/leukipp/cortile?tab=readme-ov-file
# https://github.com/leukipp/cortile/blob/main/assets/services/cortile.service
# copy systemd service file
cp cortile.service ~/.config/systemd/user/
# reload systemd configuration
systemctl --user daemon-reload
# enable systemd service
systemctl --user enable cortile.service
# start systemd service
systemctl --user start cortile.service


# Cisco VPN
# https://software.cisco.com/download/home/286330811/type/282364313/release/5.1.15.287


# Purge linux mint
# https://github.com/MK2112/Linux-Mint-Debloater


# Purge libreoffice
# https://computingforgeeks.com/uninstall-libreoffice-on-ubuntu/
sudo apt update
sudo apt remove --purge libreoffice*
sudo apt-get autoremove


# Ollama LLM
# https://ollama.com/download/linux
curl -fsSL https://ollama.com/install.sh | sh

# pipx
# https://pipx.pypa.io/stable/installation/
sudo apt update
sudo apt install pipx
pipx ensurepath

# aider
# https://aider.chat/
pipx install aider-chat


# REMINA
# https://remmina.org/how-to-install-remmina/#ubuntu
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret

#------------------------------

# AppImages
# https://antimicro.net/
wget https://github.com/AntiMicroX/antimicrox/releases/download/3.5.1/AntiMicroX-x86_64.AppImage

# :: bambulabs
wget https://github.com/bambulab/BambuStudio/releases/download/v02.05.00.65/Bambu_Studio_ubuntu-24.04_PR-9504.AppImage

# :: freetube
wget https://github.com/FreeTubeApp/FreeTube/releases/download/v0.23.13-beta/freetube-0.23.13-beta-amd64.AppImage

# :: freecad [better than flatpak]
# https://www.freecad.org/downloads.php?lang=en
wget https://github.com/FreeCAD/FreeCAD/releases/download/1.0.2/FreeCAD_1.0.2-conda-Linux-x86_64-py311.AppImage






