# Linux environment setup
The scripts in this repository provide provide a quick way to setup of a personalized development environment for Ubuntu-based linux distros running XFCE. It's meant to keep user configurations the same should the OS be reinstalled, or should one create a new user account on a stable system. 

### Installation
Run the command:

```sh
chmod -x install.sh
sh install.sh
```

### Pruning
Sometimes the repository can grow large due to huge config files generate by specific programs (ex: chrome). To make the `.git` folder smaller, run the command:

```
git gc --prune=now --aggressive
```

