#!/bin/bash

# Installazione di Fish
sudo apt-get install fish
read -p "Vuoi impostare Fish come shell predefinita? (y/n): " risposta
if [[ "$risposta" == "y" || "$risposta" == "Y" ]]; then
  sudo chsh -s $(which fish)
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

echo "Installazione completata."
