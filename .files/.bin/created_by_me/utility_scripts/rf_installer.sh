#!/bin/bash

source "logo.sh"
source "colorsBashScript.sh"
Instalar_paquetes_cli() {

    backup_folder="$HOME/fail"  # Use $HOME para la ruta
    log_file="$backup_folder/backup_log.txt" # Combina variables
    date=$(date +%Y%m%d-%H%M%S)

    # Crear directorio de respaldo si no existe
    if [ ! -d "$backup_folder" ]; then
        mkdir -p "$backup_folder" # -p crea directorios intermedios si es necesario
    fi

    # Crear archivo de registro si no existe
    if [ ! -f "$log_file" ]; then
        touch "$log_file"
    fi


  # source ~/bin/scripts/colorsBashScript.sh


lista_paquetes=("$@")


  # Lista de paquetes a instalar (repositorios oficiales y AUR)
  # paquetes=(
  #   "kew"     # nice cli music player
  #   "gt"      # substituto de tree
  #   "onefecth" # info de repo al hacer cd, esta unido a una funcion en .zshrc_functions
  #   "nnn"     # AUR
  #   "ripgrep" # Repositorio oficial
  #   "lazygit" # AUR
  #   "micro"
  #   "wget"
  #   "atuin"   #  magical shell history
  #   "gum"     # colorea salida en pantalla
  #   "eza"     # mejora la salida del comando ls
  #   "fsearch" #alternativa en linux a everything de windows"
  #   "thunar-vcs-plugin"
  #   "ffmpeg-audio-thumbnailer-git"
  #   "python-thunar-plugins-git"
  #   "thunar-shares-plugin-git"
  #   "sgsearch"
  #   "thunar-dropbox-git"
  #   "bcompare-thunar"
  #   "thunar-vcs-plugin"
  #   "imdb-thumbnailer"
  #   "bat"
  #   "bat-extras"
  #   "tldr"
  #   "python-pipx-git"
  #   "vivid" # colorear salida de tree, ls, etc
  #   "fd"
  #   "mybase-desktop-bin"         # gestion de conocimiento muy interesante
  #   "czkawka-gui-bin"            # para buscar archivos duplicados
  #   "fclones-gui"                # para buscar archivos duplicados
  #   "detwinner"                  # para buscar archivos duplicados
  #   "duff"                       # A command-line utility for quickly finding duplicates in a given set of files
  #   "chezmoi"                    # para manejar mis dotfiles
  #   "chezmoi_modify_manager-git" # para manejar mis dotfiles TODO: config this
  # )

  # Git_Install=(
  #   git github-cli hub diff-so-fancy gum dialog ghq ghq-gst evhz-git
  # )

  # dependencias=(alacritty base-devel brightnessctl bspwm dunst feh firefox geany git kitty imagemagick jq
  #   jgmenu libwebp lsd maim mpc mpd neovim ncmpcpp npm pamixer pacman-contrib
  #   papirus-icon-theme physlock picom playerctl polybar polkit-gnome python-gobject ranger
  #   redshift rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono ttf-jetbrains-mono-nerd
  #   ttf-joypixels ttf-terminus-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs
  #   xdo xdotool xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot
  #   xorg-xwininfo zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

  # Git_Install2=(
  #   git forgit vifm vifmimg-git vifm-colors-git vifm-devicons-git vlc bzip2 gzip tar unzip zip pandoc jpegoptim optipng ghostscript qpdf testdisk perl-base rhash peco wget eza
  #   yt-dlp bat bat-extras tldr
  #   diff-so-fancy geany hub github-cli peco wget eza
  #   zsh fish wget xorg-xfd curl
  #   wezterm ttf-nerd-fonts-symbols-mono python-nautilus noto-fonts-emoji xsel micro lazygit ark fzf atuin fd starship
  #   ttf-meslo-nerd gitkraken ttf-unifont noto-color-emoji-fontconfig xorg-fonts-misc ttf-dejavu ttf-meslo-nerd-font-powerlevel10k noto-fonts-emoji powerline-fonts microsoft-edge-stable-bin microsoft-edge-beta-bin bcompare brew ghq mise git-delta ydiff ghq nodejs-commitizen topgrade visual-studio-code-insiders-bin mise
  #   visual-studio-code-bin vscodium-bin vscodium-bin-marketplace vscodium-bin-features
  # )

  # Zsh_Install=(
  #   zsh fastfetch ttf-meslo-nerd siji-git noto-color-emoji-fontconfig xorg-fonts-misc ttf-dejavu ttf-meslo-nerd-font-powerlevel10k noto-fonts-emoji powerline-fonts zsh-theme-powerlevel10k zsh-theme-powerlevel10k-bin-git awesome-terminal-fonts zoxide
  # )


  #  dotbare_Install_2=(
  #  dotbare fzf bat diff-so-fancy git-delta highlight ruby-coderay tree
  #  github-cli fd git-delta lazygit ttf-firacode-nerd wl-clipboard topgrade
  #  curl wget git zsh tmux bat fzf eza unzip neovim ripgrep ncdu ranger vim zoxide
  #  bpython python-urwid python-jedi python-watchdog
  #)

# Installing gum
if ! command -v gum &>/dev/null; then  # Verifica si gum NO está instalado
      if sudo pacman -S --noconfirm gum; then  # Intenta instalar con pacman
      color_echo -b -g "gum" -w "installed" -o "successfully"
      else
          echo "pacman -S gum" >> "$log_file"  # Registra el comando fallido en el log
      fi
fi

  clear
  gum style --foreground 121 --border double --padding "1 1" --margin "1 1" --align center "Robert Dotfiles"
  echo

  # Función para verificar si un paquete está instalado
  is_installed() {
    pacman -Qi "$1" &>/dev/null
  }

  # Actualizar repositorios
  logo "Ejecutando pacman -Syu"
  echo ":: Checking Arch Linux PGP Keyring..."
  local installedver="$(LANG= sudo pacman -Qi archlinux-keyring | grep -Po '(?<=Version         : ).*')"
  local currentver="$(LANG= sudo pacman -Si archlinux-keyring | grep -Po '(?<=Version         : ).*')"
  if [ $installedver != $currentver ]; then
    echo " Arch Linux PGP Keyring is out of date."
    echo " Updating before full system upgrade."
    sudo pacman -Sy --needed --noconfirm archlinux-keyring
  else
    echo " Arch Linux PGP Keyring is up to date."
    echo " Proceeding with full system upgrade."
  fi
  sudo pacman -Syu



  logo "Verificar si PARU ya esta instalado..."

  # Installing Paru
  if command -v paru >/dev/null 2>&1; then
    color_echo -b -g "Paru" -w "is already" -o "installed"
  else
    echo""
    color_echo -w "Installing " -b -g "Paru"

    {
      cd "$HOME" || exit
      sudo pacman -S --noconfirm git base-devel
      git clone https://aur.archlinux.org/paru-bin.git
      cd paru-bin || exit
      makepkg -si --noconfirm
    } || {
      echo""
      color_echo -b -r "Failed to install" -b -c "Paru." -b -r "You may need to install it manually"
    }
  fi


  # Instalar paquetes
  logo "Comprobando e instalando paquetes requeridos..."

	for paquete in "${lista_paquetes[@]}"; do
  # for paquete in "${paquetes[@]}" "${Zsh_Install[@]}" "${dotbare_Install[@]}" "${dotbare_Install_2[@]}" "${Git_Install[@]}" "${Git_Install2[@]}" "${dependencias[@]}"; do
    if pacman -Si "$paquete" &>/dev/null; then
      origen="Repositorio oficial"
      instalador="pacman -S"
    else
      origen="AUR"
      instalador="paru -S"
    fi

    if ! is_installed "$paquete"; then
      #Verificar si el paquete está en los repositorios oficiales o en AUR
      if pacman -Si "$paquete" &>/dev/null; then
        origen="Repositorio oficial"
        instalador="pacman -S"
        echo ""
        color_echo -w "Installando" -b -g "$paquete" -o "(${origen})..."
        sudo $instalador --needed --noconfirm "$paquete" &>/dev/null
      else
        origen="AUR"
        instalador="paru -S"
        echo ""
        color_echo -w "Installando" -b -g "$paquete" -o "(${origen})..."
        $instalador --needed --noconfirm "$paquete"
      fi
      if sudo $instalador --needed --noconfirm "$paquete" &>/dev/null; then
        color_echo -b -g $paquete -w "se instaló" -o "correctamente" -b -bl "(${origen})"
        echo ""
      else
        echo""
        echo "paru -S $paquete" >>"$log_file"
        color_echo -b -r "ERROR" -w "al instalar" -b -g "$paquete." -w "Verifica los detalles en" -b -c "RiceError.log" -b -bl "(${origen})"
        echo""
        echo""
      fi
    else
      color_echo -b -g $paquete -w "is already" -o "installed" -b -bl "(${origen})"

    fi
    sleep 1 # Pausa opcional
  done

  logo "¡Instalación completa!"
  echo""
  echo "Estos paquetes no se pudieron instalar, intenta una instalacion manual: $log_file"
  bat "$log_file"
  echo""

  sleep 10

}


Instalar_paquetes_adicionales() {

  backup_folder="${HOME}/fail" # Use $HOME for the path
  log_file="${backup_folder}/backup_log.txt"
  date=$(date +%Y%m%d-%H%M%S)

  source ~/bin/scripts/colorsBashScript.sh

  color_echo -c "Este texto es" -b -r "rojo brillante y en negrita"
  color_echo -y "Texto amarillo" -g "y verde" -o "con un toque de naranja"
  color_echo -b -p "Texto morado en negrita"

  color_echo -c "Este" -b -r "es" -g "un" -y "ejemplo" -o "con" -p "muchos" -bl "colores" -w "y negrita"

  color_echo -c "Este" -b -r "es" -g "un" -w "ejemplo" -o "con" -p "muchos" -w "colores" -y "y negrita"

  # Lista de paquetes a instalar (repositorios oficiales y AUR)
  paquetes=(
    "kew"     # nice cli music player
    "gt"      # substituto de tree
    "onefecth" # info de repo al hacer cd, esta unido a una funcion en .zshrc_functions
    "nnn"     # AUR
    "ripgrep" # Repositorio oficial
    "lazygit" # AUR
    "micro"
    "wget"
    "atuin"   #  magical shell history
    "gum"     # colorea salida en pantalla
    "eza"     # mejora la salida del comando ls
    "fsearch" #alternativa en linux a everything de windows"
    "thunar-vcs-plugin"
    "ffmpeg-audio-thumbnailer-git"
    "python-thunar-plugins-git"
    "thunar-shares-plugin-git"
    "sgsearch"
    "thunar-dropbox-git"
    "bcompare-thunar"
    "thunar-vcs-plugin"
    "imdb-thumbnailer"
    "bat"
    "bat-extras"
    "tldr"
    "python-pipx-git"
    "vivid" # colorear salida de tree, ls, etc
    "fd"
    "microsoft-edge-stable-bin"
    "microsoft-edge-beta-bin"
    "google-chrome"
    "mybase-desktop-bin"         # gestion de conocimiento muy interesante
    "czkawka-gui-bin"            # para buscar archivos duplicados
    "fclones-gui"                # para buscar archivos duplicados
    "detwinner"                  # para buscar archivos duplicados
    "duff"                       # A command-line utility for quickly finding duplicates in a given set of files
    "chezmoi"                    # para manejar mis dotfiles
    "chezmoi_modify_manager-git" # para manejar mis dotfiles TODO: config this
  )

  Git_Install=(
    git github-cli hub diff-so-fancy gum dialog ghq ghq-gst evhz-git
  )

  dependencias=(alacritty base-devel brightnessctl bspwm dunst feh firefox geany git kitty imagemagick jq
    jgmenu libwebp lsd maim mpc mpd neovim ncmpcpp npm pamixer pacman-contrib
    papirus-icon-theme physlock picom playerctl polybar polkit-gnome python-gobject ranger
    redshift rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono ttf-jetbrains-mono-nerd
    ttf-joypixels ttf-terminus-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs
    xdo xdotool xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot
    xorg-xwininfo zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

  Git_Install2=(
    git forgit vifm vifmimg-git vifm-colors-git vifm-devicons-git vlc bzip2 gzip tar unzip zip pandoc jpegoptim optipng ghostscript qpdf testdisk perl-base rhash peco wget eza
    yt-dlp bat bat-extras tldr
    diff-so-fancy geany hub github-cli peco wget eza
    zsh fish wget xorg-xfd curl
    wezterm ttf-nerd-fonts-symbols-mono python-nautilus noto-fonts-emoji xsel micro lazygit ark fzf atuin fd starship
    ttf-meslo-nerd gitkraken ttf-unifont noto-color-emoji-fontconfig xorg-fonts-misc ttf-dejavu ttf-meslo-nerd-font-powerlevel10k noto-fonts-emoji powerline-fonts microsoft-edge-stable-bin microsoft-edge-beta-bin bcompare brew ghq mise git-delta ydiff ghq nodejs-commitizen topgrade visual-studio-code-insiders-bin mise
    visual-studio-code-bin vscodium-bin vscodium-bin-marketplace vscodium-bin-features
  )

  Zsh_Install=(
    zsh fastfetch ttf-meslo-nerd siji-git noto-color-emoji-fontconfig xorg-fonts-misc ttf-dejavu ttf-meslo-nerd-font-powerlevel10k noto-fonts-emoji powerline-fonts zsh-theme-powerlevel10k zsh-theme-powerlevel10k-bin-git awesome-terminal-fonts zoxide
  )

  dotbare_Install=(
    dotbare fzf bat diff-so-fancy git-delta highlight ruby-coderay tree docker docker-compose docker-buildx docker-rootless-extras
    github-cli fd git-delta lazygit ttf-firacode-nerd wl-clipboard topgrade
    curl wget git zsh tmux bat fzf eza unzip neovim ripgrep ncdu ranger vim zoxide
    bpython python-urwid python-jedi python-watchdog
  )

  clear
  gum style --foreground 121 --border double --padding "1 1" --margin "1 1" --align center "Robert Dotfiles"
  echo

  # Función para verificar si un paquete está instalado
  is_installed() {
    pacman -Qi "$1" &>/dev/null
  }

  # Actualizar repositorios
  logo "Ejecutando pacman -Syu"

  sudo pacman -Syu

  logo "Verificar si PARU ya esta instalado..."

  # Installing Paru
  if command -v paru >/dev/null 2>&1; then
    color_echo -b -g "Paru" -w "is already" -o "installed"
  else
    echo""
    color_echo -w "Installing " -b -g "Paru"

    {
      cd "$HOME" || exit
      sudo pacman -S --noconfirm git base-devel
      git clone https://aur.archlinux.org/paru-bin.git
      cd paru-bin || exit
      makepkg -si --noconfirm
    } || {
      echo""
      color_echo -b -r "Failed to install" -b -c "Paru." -b -r "You may need to install it manually"
    }
  fi

  # Instalar paquetes
  logo "Comprobando e instalando paquetes requeridos..."

  for paquete in "${paquetes[@]}" "${Zsh_Install[@]}" "${dotbare_Install[@]}" "${Git_Install[@]}" "${Git_Install2[@]}" "${dependencias[@]}"; do
    if pacman -Si "$paquete" &>/dev/null; then
      origen="Repositorio oficial"
      instalador="pacman -S"
    else
      origen="AUR"
      instalador="paru -S"
    fi

    if ! is_installed "$paquete"; then
      #Verificar si el paquete está en los repositorios oficiales o en AUR
      if pacman -Si "$paquete" &>/dev/null; then
        origen="Repositorio oficial"
        instalador="pacman -S"
        echo ""
        color_echo -w "Installando" -b -g "$paquete" -o "(${origen})..."
        sudo $instalador --needed --noconfirm "$paquete" &>/dev/null
        echo ""
      else
        origen="AUR"
        instalador="paru -S"
        echo ""
        color_echo -w "Installando" -b -g "$paquete" -o "(${origen})..."
        $instalador --needed --noconfirm "$paquete"
      fi
      if sudo $instalador --needed --noconfirm "$paquete" &>/dev/null; then
        color_echo -b -g $paquete -w "se instaló" -o "correctamente" -b -bl "(${origen})"
      else
        echo""
        echo "paru -S $paquete" >>"$log_file"
        color_echo -b -r "ERROR" -w "al instalar" -b -g "$paquete." -w "Verifica los detalles en" -b -c "RiceError.log" -b -bl "(${origen})"
        echo""
        echo""
      fi
    else
      color_echo -b -g $paquete -w "is already" -o "installed" -b -bl "(${origen})"

    fi
    sleep 1 # Pausa opcional
  done

  logo "¡Instalación completa!"
  echo""
  echo "Estos paquetes no se pudieron instalar, intenta una instalacion manual: $log_file"
  bat "$log_file"
  echo""

  sleep 10

}
