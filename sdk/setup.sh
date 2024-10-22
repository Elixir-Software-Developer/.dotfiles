#!/bin/bash

# Verificar e instalar brew si no está instalado
if ! command -v brew &> /dev/null; then
    echo "brew no está instalado. Instalando brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Función para instalar lenguajes de programación
install_languages() {
    local languages=("$@")

    for language in "${languages[@]}"; do
        case $language in
        "Ruby on Rails")
            brew install ruby
            gem install rails --no-document
            ;;
        "Node.js")
            brew install node
            ;;
        "Go")
            brew install go
            ;;
        "PHP")
            brew install php
            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
            rm composer-setup.php
            ;;
        "Python")
            brew install python
            ;;
        "Elixir")
            brew install elixir
            mix local.hex --force
            ;;
        "Rust")
            brew install rust
            ;;
        "Java")
            brew install openjdk
            ;;
        *)
            echo "Lenguaje no reconocido: $language"
            ;;
        esac
    done
}

# Lista de lenguajes disponibles
AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")

# Mostrar opciones al usuario
echo "Selecciona los lenguajes de programación a instalar (separados por espacios):"
for i in "${!AVAILABLE_LANGUAGES[@]}"; do
    echo "$((i+1)). ${AVAILABLE_LANGUAGES[$i]}"
done

# Leer la selección del usuario
read -p "Ingresa los números de los lenguajes (ejemplo: 1 3 5): " selections

# Convertir selecciones en índices válidos
selected_languages=()
for selection in $selections; do
    if [[ $selection -ge 1 && $selection -le ${#AVAILABLE_LANGUAGES[@]} ]]; then
        selected_languages+=("${AVAILABLE_LANGUAGES[$((selection-1))]}")
    else
        echo "Selección inválida: $selection"
    fi
done

# Instalar los lenguajes seleccionados
if [[ ${#selected_languages[@]} -gt 0 ]]; then
    install_languages "${selected_languages[@]}"
else
    echo "No se seleccionaron lenguajes para instalar."
fi
