# Ubuntu Setup - 22.04
Setup script for new Ubuntu machines.

## What does it do?
- [x] Creates `~/dev` directory
- [x] Runs system update and upgrade
- [x] Adds the current user to the `docker` group
- [x] Exibits a cool spinner to let you know the script is running
- [x] Installs the following:
    - [x] build-essential
    - [x] file
    - [x] git
    - [x] gh
    - [x] jq
    - [x] tree
    - [x] curl
    - [x] net-tools
    - [x] nmap
    - [x] docker
    - [x] docker-compose
    - [x] nvm, npm, node (v18 LTS)
    - [x] pyenv, pip3, python3 (v3.10)

# Usage
Make sure to give this script executable permissions before running it.
```bash
chmod +x setup.sh
```

Run the script
```bash
./setup.sh
```

**Enjoy! :tada:**