# Install script to setup an XFCE install
mkdir downloads
cd downloads

#------ grub config
# https://ubuntuhandbook.org/index.php/2024/08/enable-zswap-ubuntu/

sudo nano /etc/default/grub
# “GRUB_CMDLINE_LINUX_DEFAULT” -> zswap.enabled=1 
# “GRUB_CMDLINE_LINUX_DEFAULT” -> remove -> splash
sudo update-grub

#------- base programs -------
#:: Tools
sudo apt install wget
sudo apt install jq
sudo apt install htop
sudo apt install lm-sensors
sudo apt install stress

sudo apt install git
sudo apt install gparted

# For intel:
#sudo apt install intel-gpu-tools
#sudo apt-get install thermald
#sudo systemctl enable thermald

#:: TLP
sudo apt install tlp tlp-rdw
sudo systemctl enable --now tlp.service
# Move config to:
# /etc/tlp.conf

#:: File tranfer
sudo apt install syncthing
sudo apt install syncthing-gtk
systemctl --user start syncthing

#:: gui tools
sudo apt install vlc
sudo apt install kdiskmark
sudo apt install screengrab
#sudo apt install gnome-system-monitor
sudo apt install kolourpaint

# :: qt platform themes
# https://bbs.archlinux.org/viewtopic.php?id=259721
# https://askubuntu.com/questions/910012/how-can-i-get-qt5-applications-to-use-the-gtk-theme-in-ubuntu-17-04
# https://www.youtube.com/watch?v=yhbDy_i9X1w
sudo apt install qt5ct
sudo apt install qt6ct
sudo cp ../qt5.conf /etc/environment.d/qt5.conf


# :: debloat
sudo apt remove yaru-theme-icon
sudo apt remove xfce4-screenshooter

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
#flatpak install flathub org.deskflow.deskflow

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

# edit scale of vscode:
# window.zoomLevel = 1

# :: helpers
flatpak install flathub com.github.jeromerobert.pdfarranger
flatpak install flathub io.github.alainm23.planify
flatpak install flathub com.rustdesk.RustDesk
#flatpak install flathub net.mkiol.SpeechNote
#flatpak install flathub io.github.jonmagon.kdiskmark

# :: misc
flatpak install flathub io.freetubeapp.FreeTube
flatpak install flathub org.js.nuclear.Nuclear
flatpak install flathub io.github.davidoc26.wallpaper_selector

# :: chat
flatpak install flathub org.telegram.desktop
#flatpak install flathub org.signal.Signal

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


# :: waydroid installer
# https://github.com/1999AZZAR/use-waydroid-on-x11/tree/master
git clone https://github.com/1999AZZAR/use-waydroid-on-x11.git
cd use-waydroid-on-x11
sudo sh install.sh

# desktop entry
#sh waydroid-session.sh 
sudo cp waydroid-session.sh /usr/bin/waydroid-session.sh
sudo chmod +x /usr/bin/waydroid-session.sh
sudo cp ../../waydroid-session.desktop /usr/share/applications/waydroid-session.desktop
#sudo chmod +x /usr/share/applications/waydroid-session.desktop
cd ..

# If using gapps, register:
# https://docs.waydro.id/faq/google-play-certification

# :: waydroid script 
# https://github.com/casualsnek/waydroid_script
git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py

# Install Libhoudini for intel/amd; libndk for AMD (older?)

# :: make shared folder
# https://docs.waydro.id/faq/setting-up-a-shared-folder
sudo mkdir /mnt/waydroid
sudo bindfs --mirror=$(id -u) ~/.local/share/waydroid/data/media/0 /mnt/waydroid


# :: networking [firewall]
# https://docs.waydro.id/debugging/networking-issues
# Change to home profile
sudo ufw allow 53
sudo ufw allow 67
sudo ufw default allow FORWARD

# :: reinstall rom if messed up
# https://github.com/waydroid/waydroid/discussions/1358
# sudo rm -rf ~/.local/share/waydroid
# sudo rm -rf /var/lib/waydroid

cd ..

# miniconda
# https://www.anaconda.com/docs/getting-started/miniconda/install#linux-terminal-installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash ./Miniconda3-latest-Linux-x86_64.sh
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

# download binary
mkdir cortile
cd cortile

wget -qO- $(wget -qO- https://api.github.com/repos/leukipp/cortile/releases/latest | \
jq -r '.assets[] | select(.name | contains ("linux_amd64.tar.gz")) | .browser_download_url') | \
tar -xvz

# move file to binary
cp ../../cortile.service cortile.service
sudo cp cortile /usr/local/bin/cortile

mkdir -p ~/.config/systemd/user

# copy systemd service file
cp cortile.service ~/.config/systemd/user/
# reload systemd configuration
systemctl --user daemon-reload
# enable systemd service
systemctl --user enable cortile.service
# start systemd service
systemctl --user start cortile.service

cd ..

# Cisco VPN
# https://software.cisco.com/download/home/286330811/type/282364313/release/5.1.15.287
sudo ssh ../cisco-secure-client-linux64.sh

# Purge linux mint
# https://github.com/MK2112/Linux-Mint-Debloater
sudo apt remove rhythmbox pix sticky hypnotix celluloid warpinator thingy xfce4-dict   
sudo apt remove drawing         
# thunderbird
# simple-scan            


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
#sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina #remmina-plugin-rdp remmina-plugin-secret

# Antimicrox
sudo apt install antimicrox

#------------------------------

# AppImages
mkdir appimages
cd appimages

# https://antimicro.net/
wget https://github.com/AntiMicroX/antimicrox/releases/download/3.5.1/AntiMicroX-x86_64.AppImage

# :: bambulabs
wget https://github.com/bambulab/BambuStudio/releases/download/v02.05.00.65/Bambu_Studio_ubuntu-24.04_PR-9504.AppImage

# :: freetube
wget https://github.com/FreeTubeApp/FreeTube/releases/download/v0.23.13-beta/freetube-0.23.13-beta-amd64.AppImage

# :: freecad [better than flatpak]
# https://www.freecad.org/downloads.php?lang=en
wget https://github.com/FreeCAD/FreeCAD/releases/download/1.0.2/FreeCAD_1.0.2-conda-Linux-x86_64-py311.AppImage

# :: Cura ultimaker
# https://github.com/Ultimaker/Cura/releases/
wget https://github.com/Ultimaker/Cura/releases/download/5.10.2/UltiMaker-Cura-5.10.2-linux-X64.AppImage

# :: drawio [better file integration]
wget https://github.com/jgraph/drawio-desktop/releases/download/v29.5.2/drawio-x86_64-29.5.2.AppImage

cd ..

# :: Folders
#git clone https://github.com/PapirusDevelopmentTeam/papirus-folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C paleorange --theme Papirus-Dark

#---- hibernation ----
# https://ubuntuhandbook.org/index.php/2021/08/enable-hibernate-ubuntu-21-10/

# :: increase swap space
# https://linuxconfig.org/how-to-increase-swap-space-on-linux


#:: Steam 
sudo apt install steam-installer

#---- displaylink drivers
# https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb

sudo apt install ./synaptics-repository-keyring.deb
sudp apt update
sudo apt install displaylink-driver

# https://github.com/AdnanHodzic/displaylink-debian
#git clone https://github.com/AdnanHodzic/displaylink-debian.git
#cd displaylink-debian
#sudo ./displaylink-debian.sh
#cd ..


#--- xfce suspend error
# Suspend error: fix with power manager settings
# https://forums.linuxmint.com/viewtopic.php?p=2544132

# Fix with XML file:
# https://forums.linuxmint.com/viewtopic.php?f=57&t=259912&p=2025367#p2025367
sudo nano /usr/share/polkit-1/actions/org.freedesktop.login1.policy

# Modify as shown:
#<action id="org.freedesktop.login1.suspend">
#        <description gettext-domain="systemd">Suspend the system</description>
#        <message gettext-domain="systemd">Authentication is required to suspend the system.</message>
#        <defaults>
#                <allow_any>yes</allow_any>
#                <allow_inactive>yes</allow_inactive>
#                <allow_active>yes</allow_active>
#        </defaults>
#</action>

# Fix with polkit
# https://stijn.tintel.eu/blog/2015/09/11/polkit-requesting-root-password-to-suspend-after-updating-version-0112-to-0113/
sudo cp ../85-suspend.rules /etc/polkit-1/rules.d/85-suspend.rules

#--- Install peer-to-peer VPN
# :: netbird
# https://app.netbird.io/install
curl -fsSL https://pkgs.netbird.io/install.sh | sh
netbird up

#--- add essential icon themes
sudo apt install greybird-gtk-theme 
sudo apt install elementary-xfce-icon-theme

#---- complete

sudo apt autoremove
sudo flatpak uninstall --unused

