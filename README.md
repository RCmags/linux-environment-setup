# Linux environment setup
The scripts in this repository are orovide a pre-defined setup and work environment for 
fresh linux installs with XFCE. 

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

