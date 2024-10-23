#!/bin/bash

# Cargar scripts necesarios
# SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SCRIPT_DIR" || return 1
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
cargar_script "common_functions.sh"
cargar_script "logo.sh"

logo "creating a backup of the tmux folder in .config and $HOME, if they exist."
backup_folder_in_config tmux
backup_folder_in_home .tmux

# Llamar a la función para preguntar al usuario si desea continuar
# ask_to_continue

mkdir -p ~/.config/tmux

logo "Enlace simbólico creado: $SDIR/tmux.conf -> ~/.config/tmux/tmux.conf"
 ln -sfv "$SDIR/tmux.conf" ~/.config/tmux/tmux.conf

logo "Cloning or updating Tmux Plugin Manager"
clone_or_update_repo https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm

logo "install tmux plugins"
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh

logo "add plugins to PATH"
ln -sfnv ~/.config/tmux/plugins/tmux-tea/bin/tea.sh  ~/.local/bin/tea
