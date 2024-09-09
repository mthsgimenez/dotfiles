#!/bin/bash

BACKUP_DIR="$HOME/.config_old"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for dir in */; do
   path="$HOME/.config/${dir::-1}" # Eg: /home/user/.config/sway

   # path already exists
   if [ -d "$path" ]; then
      # it's a symlink
      if [ -L "$path" ]; then
         printf "removing symlink: $path\n"
         unlink $path
      else
         dest="$BACKUP_DIR/${dir::-1}"
         printf "moving existing config to $dest\n"
         if [ ! -d "$dest" ]; then
            mkdir -p "$dest"
         fi
         mv $path $dest
      fi
   fi

   printf "creating symlink for ${dir::-1}\n\n"
   ln -sr "$SCRIPT_DIR/${dir::-1}" $path
done
