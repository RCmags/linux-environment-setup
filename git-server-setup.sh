#--- Commands to setup git server via SSH ----

# 1. create user for git
# https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04

sudo adduser git
# >> answer prompts for password

# :: encrypt home folder
# https://ubuntushell.com/encrypt-home-folder-in-ubuntu/

sudo ecryptfs-migrate-home -u git

# NOTE: The above will BREAK if the user password is changed. [CAN'T LOGIN]
# Follow this procedure to AVOID:
# https://forums.linuxmint.com/viewtopic.php?t=266204

ecryptfs-rewrap-passphrase /home/.ecryptfs/$USER/.ecryptfs/wrapped-passphrase
# ^ passpharse refers to user login password

sudo passwd git

# Login and get passphrase
su git
ecryptfs-unwrap-passphrase

# :: install vpn
# https://app.netbird.io/install

# 2. Install ssh server
# https://linuxconfig.org/quick-guide-to-enabling-ssh-on-ubuntu-24-04

sudo apt install ssh
sudo systemctl enable ssh

# :: Limit access
# sudo ufw allow ssh # General for all

ipsource=192.168.1.100
sudo ufw allow from $ipsource to any port 22 # default ssh port

# 3. Copy ssh-key [on client]
# https://phoenixnap.com/kb/ssh-with-key
# NOTE: use netbird IP

# ssh-copy-id -i <path-to-key.pub> <user>@<server-ip>
# ssh <user>@<server-ip>

# 4. Dissable password login
sudo nano /etc/ssh/sshd_config

# :: set the following:
# PasswordAuthentication no

sudo systemctl restart sshd

# 5. Instal rustdesk for redundacy
# https://github.com/rustdesk/rustdesk/releases
# NOTE: disk encryption may cause ssh to fail at first boot. Need to manually login to decrypt

# 6. Install xrdp
# https://www.cherryservers.com/blog/install-xrdp-on-ubuntu-2404
sudo apt install xrdp
sudo systemctl status xrdp

# :: configure to enable timeout
# https://oneuptime.com/blog/post/2026-01-15-setup-xrdp-remote-desktop-ubuntu/view
sudo nano /etc/xrdp/sesman.ini

# ^ set the following:
#KillDisconnected=true
#DisconnectedTimeLimit=10


# :: install google authenticator for 2FA
# https://linux.how2shout.com/enabling-google-authenticator-on-ubuntu-24-04-for-two-factor-authentication/

sudo apt install libpam-google-authenticator

# generate code
google-authenticator

# :: append 2fa to password [append auth-code to end of password]
sudo nano /etc/pam.d/xrdp-sesman

# Append to the start of `xrdp-sesman`:
# auth required pam_google_authenticator.so forward_pass nullok

# NOTE: appyling google authentication to the login can be easily-undone
# by editing the content in /etc/ should the OS be unencrypted.

######## OPTIONAL #########
# NOTE: remove `nullok` to force 2FA. Encrypted drives will fail to
# login on first attempt. Beware!

#--------------------
# ::: [Enforce 2FA at login screen
# On LightDM login screen:

#sudo nano /etc/pam.d/lightdm

# append below @include common-auth:
# auth required pam_google_authenticator.so nullok

#--------------------
# :: restrict to certain users
# NOTE: This is buggy!!!
# https://askubuntu.com/questions/1433247/ubuntu-22-04-xrdp-allow-multiple-sessions-and-restrict-some-users

#sudo groupadd tsusers
#sudo usermod -aG tsusers git
#sudo usermod -aG tsusers admin

# :: modify group policy
# Not always needed? See:
# https://c-nergy.be/blog/?p=18536

#sudo nano /etc/xrdp/sesman.ini
# change the line 'AlwaysCheckGroup from false to true'

# :: If the config messes up, run:
# sudo apt purge xrdp

# Then reinstall xrdp to start from scatch
#--------------------

# Limit XRDP to specific IP address(s)
# allow for all 
sudo ufw allow 3389/tcp

# block all
sudo ufw deny 3389/tcp

# allow selective
ipsource=192.168.1.100  # Client IP
sudo ufw allow from $ipsource to any port 3389

# ^ Repeat for all desired clients

# If a rule is incorrect, run:
#sudo ufw delete allow from $ipsource to any port 3389


