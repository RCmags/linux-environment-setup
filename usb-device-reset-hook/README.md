# Simple hook to reset usb device
Use the following steps to 

0. Edit the `deviceid` variable in `usbnreset` by assigning it the target device listed in `lsusb`

1. Copy the script to: 
```
sudo nano /lib/systemd/system-sleep/usbreset
sudo chmod +x /lib/systemd/system-sleep/usbreset
```

2. Test the script with:
```
sudo /lib/systemd/system-sleep/usbreset post suspend
``
