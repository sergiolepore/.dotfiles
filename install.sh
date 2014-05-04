#!/bin/bash

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#   Filename: install.sh                                                     "
# Maintainer: Sergio Lepore <sergio.d.lepore@gmail.com>                      "
#        URL: https://github.com/sergiolepore/.dotfiles                      "
#                                                                            "
#                         === Dotfiles installer ===                         "
#                                                                            "
# Inspired on:                                                               "
#   https://github.com/robb/.dotfiles                                        "
#   https://github.com/ndbroadbent/dotfiles                                  "
#   https://github.com/cowboy/dotfiles                                       "
#                                                                            "
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

. _commons.sh

if [[ $EUID -eq 0 ]]; then
    echo -e "\e[01;31mPlease do not use sudo to run this script!\e[00m" 2>&1
    e_error "Installation failed"
    exit 1
fi

e_header "Dotfiles - Sergio Lepore - http://www.sergiolepore.net/"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

Usage: $(basename "$0")

See the README.md file for documentation.
https://github.com/sergiolepore/.dotfiles

This project is unlicensed and anyone is free to copy, modify, publish, 
use, compile, sell, or distribute any file on this repository.
For more information, please refer to http://unlicense.org/
HELP
exit; fi

set -e

#
# === Run all installation scripts ===
#

e_header "____Preparing scripts____"

installers=$(find . -name "*.install" | sort)

install_all=false
skip_all_installers=false

for installer in $installers; do
    install=false
    installer_basename=$(basename $installer .install)

    if ! $install_all; then
        while true; do
            echo -e "\nDo you want to run $installer_basename script?"
            echo "[i]nstall, [I]nstall all, [s]kip, [S]kip all "
            read answer
            case $answer in
                "i" ) install=true; break;;
                "I" ) install_all=true; break;;
                "s" ) continue 2;; # continue installer loop
                "S" ) break 2;; # break out the installer loop
                *   ) continue ;;
            esac
        done
    fi

    if $install || $install_all; then
        sh -c "${installer}"
    fi
done

#
# === Now create all symlinks ===
#

e_header "____Copying symlinks____"

symlinks=$(find $DOTFILES -name "*.symlink")

overwrite_all=false
backup_all=false

for file in $symlinks; do
    overwrite=false
    backup=false

    basename=$(basename $file .symlink)
    target="$HOME/$basename"

    if [ -e "$target" ] || [ -h "$target" ]; then
        if ! $overwrite_all && ! $backup_all; then
            while true; do
                echo "$target already exists"
                echo "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all "
                read answer
                case $answer in
                    "s" ) continue 2;; # continue the outer for loop
                    "S" ) break 2;;    # break out of the outer for loop
                    "o" ) overwrite=true; break;;
                    "O" ) overwrite_all=true; break;;
                    "b" ) backup=true; break;;
                    "B" ) backup_all=true; break;;
                    *   ) continue ;;
                esac
            done
        fi

        if $overwrite || $overwrite_all; then
            rm $target
        fi

        if $backup  || $backup_all; then
            mv $target "$HOME/$basename.backup"
        fi
    fi

    echo -e "\n→ Installing $target\n"
    ln -s "$file" "$target"
done

e_success "Done."
e_header "Have a nice day! \|°▿▿▿▿°|/"
