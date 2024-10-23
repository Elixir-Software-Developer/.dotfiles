#!/bin/bash

# Cargar scripts necesarios
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
cargar_script "common_functions.sh"
cargar_script "logo.sh"


backup_folder_in_home "bin/created_by_me/bin_nvims"

# Ruta de la carpeta de origen (un nivel por encima de la carpeta actual)
source_dir="$(dirname "$(pwd)")/bin/created_by_me/bin_nvims"

# Ruta de la carpeta de destino
target_dir="$HOME/bin/created_by_me/"

# Verificar si el directorio de destino existe, si no, crearlo
if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

# Crear el enlace simbólico
ln -sf "$source_dir" "$target_dir"

logo "Enlace simbólico creado: $target_dir -> $source_dir"
install_with_brew chafa

logo "Cloning or updating LazyMan."
clone_or_update_repo https://github.com/doctorfree/nvim-lazyman $HOME/.config/nvim-Lazyman

logo "Cloning or updating my personal Neovim configuration."
clone_or_update_repo git@github.com:Elixir-Software-Developer/nvim_new.git $HOME/.config/nvim-new

logo "Cloning or updating my new personal Neovim configuration under construction."
clone_or_update_repo git@github.com:Elixir-Software-Developer/nvim.git $HOME/.config/nvim

logo "Next, we will utilize LazyMan to initialize multiple Neovim configurations."

while true; do
    read -rp " Do you wish to continue? [y/N]: " yn
    case $yn in
        [Yy]* ) break ;;
        [Nn]* ) exit ;;
        * ) printf " Error: just write 'y' or 'n'\n\n" ;;
    esac
done
clear

# Install lazyman with the following two commands:
# git clone https://github.com/doctorfree/nvim-lazyman $HOME/.config/nvim-Lazyman
$HOME/.config/nvim-Lazyman/lazyman.sh

lazyman -l #lazyvim
lazyman -c #NvChad
lazyman -w Craftzdog
lazyman -w Primeagen
lazyman -x 2k
lazyman -w Josean
lazyman -C https://github.com/yetone/cosmos-nvim.git -N nvim-Cosmos
