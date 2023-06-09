#!/bin/bash

#######################################################################
# This script installs software on a new Ubuntu 22.04 server/machine. #
# Made by Max L. (@snowboardit)                                       #
#######################################################################

# Spinner function
spinner() {
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# load ~/.bashrc with aliases
chmod +x ./aliases.sh
./aliases.sh

# make a dev directory in home
mkdir ~/dev

# update the system
sudo apt update -y & spinner
sudo apt upgrade -y & spinner

# install common unix utilities
sudo apt install -y build-essential file git jq tree & spinner

# Setup git name and email
git config --global user.email "max@maxlareau.com"
git config --global user.name "Max"

# install networking utilities
sudo apt install -y curl net-tools nmap & spinner

# install nvm, then node and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash & spinner
source ~/.bashrc
nvm install 18.14 --default & spinner
nvm use 18.14 & spinner

# install Docker
sudo apt update & spinner
sudo apt install -y ca-certificates curl gnupg & spinner
sudo install -m 0755 -d /etc/apt/keyrings & spinner
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg & spinner
sudo chmod a+r /etc/apt/keyrings/docker.gpg & spinner
echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null & spinner
sudo apt update & spinner
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin & spinner

# Add user to docker group
sudo usermod -aG docker ${USER} & spinner

# install PyEnv, then Python and pip
curl https://pyenv.run | bash & spinner
source ~/.bashrc
pyenv install 3.10 & spinner
pyenv global 3.10 & spinner

# install GitHub client (gh)
sudo snap install gh & spinner
gh auth login
gh auth status

# Print out versions
echo "-------------------------"
echo "Installation versions:"
gh -v
node -v
npm -v
docker -v
python3 -V
pip3 -V
echo "-------------------------"

# installation complete
echo "Installation completed successfully!"
