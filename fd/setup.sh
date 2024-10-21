#!/bin/bash


# Cargar scripts necesarios
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
cargar_script "common_functions.sh"


backup_folder_in_config fd

mkdir -p ~/.config/fd
ln -sf "$SDIR/ignore" ~/.config/fd/ignore
