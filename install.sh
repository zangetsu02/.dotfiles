#!/bin/bash


sudo apt update

# Installazione di Fish
sudo apt-get install fish
read -p "Vuoi impostare Fish come shell predefinita? (y/n): " risposta
if [[ "$risposta" == "y" || "$risposta" == "Y" ]]; then
  sudo chsh -s $(which fish)
  echo 'fish' >> ~/.bashrc

fi

# Dipendenze per Alacritty
sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# Installazione di Rust
if ! command -v rustup &> /dev/null; then
  sudo apt install rustup
  rustup update
fi

# Installazione di Alacritty tramite Snap
if ! command -v snap &> /dev/null; then
  echo "Snap non trovato, installazione di Alacritty fallita"
  exit 1
else
  sudo snap install alacritty --classic
fi

# Installazione di Eza 
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Copia delle configurazioni
if [ -d fish ]; then
  cp -r fish ~/.config/
else
  echo "Directory fish non trovata"
fi

if [ -d alacritty ]; then
  cp -r alacritty ~/.config/
else
  echo "Directory alacritty non trovata"
fi


read -p "Vuoi installare fnm (Fast Node Manage)? (y/n): " risposta
if [[ "$risposta" == "y" || "$risposta" == "Y" ]]; then
  curl -fsSL https://fnm.vercel.app/install | bash

  read -p "Vuoi installare l ultima versione lts di node? (y/n): " risposta
  if [[ "$risposta" == "y" || "$risposta" == "Y" ]]; then
    fnm install
    fnm use
  fi
fi

# Fonts (Serve un NerdFont ad eza per far vedere le icone)
cd /usr/local/share/fonts
sudo cp fonts/Hack/*.ttf /usr/local/share/fonts
sudo fc-cache -fv


source ~/.bashrc

echo "Installazione completata."
