#--- Commands to setup encrypted shared drive ----

# :: Ensure user is created
sudo adduser git

# Generate group for encrypted drives
sudo groupadd encrypt_group
sudo usermod -aG encrypt_group git

# >> Add other users with the above command as needed

# :: Mount the drive
# https://askubuntu.com/questions/63594/mount-encrypted-volumes-from-command-line

# open LUKS lock
sudo cryptsetup luksOpen /dev/sda1 my_encrypted_volume  # prompts for passphrase

# Mount
sudo mkdir /media/my_device
sudo mount /dev/mapper/my_encrypted_volume /media/my_device

# ^ The above is temporary. When using thunar, the drive is mounted at:
# /media/<username>/<drive-label>

# :: grant permissions to common group
# NOTE: This must be performed to ensure all chosen users can access drive.
sudo chown -R user:encrypt_group /media/my_device
sudo chmod -R 775 /media/my_device                   # grant read/write to group

# :: Mount drive at boot
# https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/


# :: allow git access to repo(s)
# https://github.com/orgs/community/discussions/162498
# logged in as `git` on SERVER
sudo su git
git config --global --add safe.directory "/media/my_device/repo.git" 

# use "*" if subfolder does not work.

# Clear mismatched configs with:
#git config --global --unset safe.directory

# View config with:
# git config --global --list


