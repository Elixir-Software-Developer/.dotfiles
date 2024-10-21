#!/bin/bash

# set -euo pipefail

# Cargar scripts necesarios
SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) && cd "$SDIR" || exit 1
cargar_script "common_functions.sh"

# Create test files and folders
create_test_files() {
    # Create test file in $HOME
    echo "Test file in $HOME" > ~/test_file_home.txt

    # Create test file in $HOME/.config/
    mkdir -p ~/.config/test_config
    echo "Test file in $HOME/.config/" > ~/.config/test_file_config.txt

    # Create test folder in $HOME/.config/
    mkdir -p ~/.config/test_folder_config

    # Create test folder in $HOME
    mkdir -p ~/test_folder_home
}

# Clean up test files and folders
cleanup_test_files() {
    rm -rf ~/test_file_home.txt
    rm -rf ~/.config/test_config/test_file_config.txt
    rm -rf ~/.config/test_folder_config
    rm -rf ~/test_folder_home
}

# Test backup functions
test_backup() {
    # echo "Testing backup functions..."

    # Test backup_file
    echo "Testing backup file in $HOME"
    backup_file_in_home test_file_home.txt
 echo "..............................................."


    # Test backup_file_config
    echo "Testing backup file in $HOME/.config/..."
    backup_file_in_config test_file_config.txt
    echo "..............................................."

    # Test backup_folder
    echo "Testing backup folder in $HOME/.config/..."
    backup_folder_in_config test_folder_config
    echo "..............................................."

    # Test backup_folder_home
    echo "Testing backup folder in $HOME..."
    backup_folder_in_home test_folder_home
    echo "..............................................."

    echo "Testing complete."
}

# Main function
main() {
    create_test_files
    test_backup
    cleanup_test_files
}

# Run main function
 main
