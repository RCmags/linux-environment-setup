#--- Commands to setup git server via SSH ----

# 1. create user for git
# https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04

sudo adduser git
# >> answer prompts for password

# :: encrypt home folder
# https://ubuntushell.com/encrypt-home-folder-in-ubuntu/

sudo ecryptfs-migrate-home -u git

# Login and get passphrase
su git
ecryptfs-unwrap-passphrase

# :: install vpn
# https://app.netbird.io/install

# 2. Install ssh server
# https://linuxconfig.org/quick-guide-to-enabling-ssh-on-ubuntu-24-04

sudo apt install ssh
sudo systemctl enable ssh
#  sudo ufw allow ssh

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
# NOTE: disk encryption may cause ssh to fail at first boot.

