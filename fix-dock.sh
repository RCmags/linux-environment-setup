# Commands to fix the lenovo dock when the laptop lid is closed

sudo apt install pipx
pipx install autorandr

# configure displays with xfce app, then enter:
autorandr --save dock

# test the configuration with:
autorandr --load dock

