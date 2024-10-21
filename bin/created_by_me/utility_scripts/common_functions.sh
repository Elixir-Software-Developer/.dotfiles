#!/usr/bin/env bash

# Define colors and styles
CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

# Backup directory
backup_folder=~/.RiceBackup

# Function to initialize the backup process
init_backup() {
    date=$(date +%Y%m%d-%H%M%S)
    printf "\n"
    # printf "\n       Backup files will be stored in %s%s%s/.RiceBackup%s \n" "${BLD}" "${CRE}" "$HOME" "${CNC}"
    # sleep 1
    [ ! -d "$backup_folder" ] && mkdir -p "$backup_folder"
}

# Function to backup a file
backup_file_home() {
    local file_to_backup="$1"
    if [ -f ~/$file_to_backup ]; then
        mv "$HOME/$file_to_backup" "$backup_folder/${file_to_backup}_$date" 2>> RiceError.log
        if [ $? -eq 0 ]; then
            printf "%s%s       ~/%s file backed up successfully at %s%s/%s_%s%s\n\n" "${BLD}" "${CGR}" "$file_to_backup" "${CBL}" "$backup_folder" "$file_to_backup" "$date" "${CNC}"
        else
            printf "%s%sFailed to backup ~/%s file. See %sRiceError.log%s\n\n" "${BLD}" "${CRE}" "$file_to_backup" "${CBL}" "${CNC}"
        fi
    else
        printf "%s%s       ~/%s file does not exist, %sno backup needed%s\n\n" "${BLD}" "${CGR}" "$file_to_backup" "${CYE}" "${CNC}"
    fi
}

# Function to backup a file in $HOME/.config/
backup_file_config() {
    local file_to_backup="$1"


    if [ -f "$HOME/.config/$file_to_backup" ]; then
        mv "$HOME/.config/$file_to_backup" "$backup_folder/${file_to_backup}_$date" 2>> RiceError.log
        if [ $? -eq 0 ]; then
            printf "%s%s       ~/.config/%s file backed up successfully at %s%s/%s_%s%s\n\n" "${BLD}" "${CGR}" "$file_to_backup" "${CBL}" "$backup_folder" "$file_to_backup" "$date" "${CNC}"
        else
            printf "%s%sFailed to backup ~/.config/%s file. See %sRiceError.log%s\n\n" "${BLD}" "${CRE}" "$file_to_backup" "${CBL}" "${CNC}"
        fi
    else
        printf "%s%s       ~/.config/%s file does not exist, %sno backup needed%s\n\n" "${BLD}" "${CGR}" "$file_to_backup" "${CYE}" "${CNC}"
    fi
}

# Function to backup a folder in ~/.config
backup_folder_config() {
    local folder_to_backup="$1"
    if [ -d "$HOME/.config/$folder_to_backup" ]; then
        mv "$HOME/.config/$folder_to_backup" "$backup_folder/${folder_to_backup}_$date" 2>> RiceError.log
        if [ $? -eq 0 ]; then
            printf "%s%s       ~/.config/%s folder backed up successfully at %s%s/%s_%s%s\n\n" "${BLD}" "${CGR}" "$folder_to_backup" "${CBL}" "$backup_folder" "$folder_to_backup" "$date" "${CNC}"
        else
            printf "%s%sFailed to backup  ~/.config/%s folder. See %sRiceError.log%s\n\n" "${BLD}" "${CRE}" "$folder_to_backup" "${CBL}" "${CNC}"
        fi
    else
        printf "%s%s       ~/.config/%s folder does not exist, %sno backup needed%s\n\n" "${BLD}" "${CGR}" "$folder_to_backup" "${CYE}" "${CNC}"
    fi
}

# Function to backup a folder in $HOME
backup_folder_home() {
    local folder_to_backup="$1"
    if [ -d "$HOME/$folder_to_backup" ]; then
        mv "$HOME/$folder_to_backup" "$backup_folder/${folder_to_backup}_$date" 2>> RiceError.log
        if [ $? -eq 0 ]; then
            printf "%s%s       ~/%s folder backed up successfully at %s%s/%s_%s%s\n\n" "${BLD}" "${CGR}" "$folder_to_backup" "${CBL}" "$backup_folder" "$folder_to_backup" "$date" "${CNC}"
        else
            printf "%s%sFailed to backup ~/%s folder. See %sRiceError.log%s\n\n" "${BLD}" "${CRE}" "$folder_to_backup" "${CBL}" "${CNC}"
        fi
    else
        printf "%s%s       ~/%s folder does not exist, %sno backup needed%s\n\n" "${BLD}" "${CGR}" "$folder_to_backup" "${CYE}" "${CNC}"
    fi
}


backup_folder_in_config(){
# Initialize backup
init_backup

# Backup the folder
backup_folder_config "$1"
}


backup_file_in_config(){

# Initialize backup
init_backup

# Backup the file in $HOME/.config/
backup_file_config "$1"

}

backup_folder_in_home(){
# Initialize backup
init_backup

# Backup the folder
backup_folder_home "$1"
}

backup_file_in_home(){

# Initialize backup
init_backup

# Backup the file
backup_file_home "$1"

}
