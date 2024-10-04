#!/bin/bash

# Función para agregar carpetas al PATH de forma recursiva
add_to_path_recursive() {
    local dir="$1"
    local depth="$2"

    # Verificar si la carpeta existe
    if [ -d "$dir" ]; then
        # Verificar si la carpeta ya está en el PATH
        if [[ ":$PATH:" != *":$dir:"* ]]; then
            # Agregar la carpeta al PATH temporalmente
            export PATH="$dir:$PATH"
            echo "Agregada al PATH temporalmente: $dir"

            # Verificar si la carpeta ya está en el archivo .zshrc
            if ! grep -q "export PATH=\"$dir:\$PATH\"" ~/.zshrc; then
                # Agregar la carpeta al PATH permanentemente
                echo "export PATH=\"$dir:\$PATH\"" >> ~/.zshrc
                echo "Agregada al PATH permanentemente: $dir"
            else
                echo "La carpeta ya está en el archivo .zshrc: $dir"
            fi
        else
            echo "La carpeta ya está en el PATH: $dir"
        fi

        # Recorrer subcarpetas
        for subdir in "$dir"/*; do
            if [ -d "$subdir" ]; then
                add_to_path_recursive "$subdir" "$((depth + 1))"
            fi
        done
    fi
}

# Carpeta raíz desde la cual comenzar la búsqueda recursiva
root_dir="$1"

# Verificar si se proporcionó una carpeta raíz
if [ -z "$root_dir" ]; then
    echo "Uso: $0 <carpeta_raíz>"
    exit 1
fi

# Llamar a la función recursiva
add_to_path_recursive "$root_dir" 0

# Recargar el archivo de configuración del shell para aplicar los cambios inmediatamente
source ~/.zshrc
