#!/usr/bin/env bash





## Function to display the menu
display_menu() {
  clear
  gum style --foreground 121 --border double --padding "1 1" --margin "1 1" --align center "Robert Dotfiles"
  echo
  color_echo -b -y "Hello" -b -c "$USER," -b -y "please select an option. Press 'i' for the Wiki."
  echo
  color_echo -b -r "      1." -g "    Configurar" -o "SSH" -w "y" -o "GPG"

  echo
  color_echo -b -bl "Type your selection or " -o "'q'" -b -bl " to return to main menu."

}
