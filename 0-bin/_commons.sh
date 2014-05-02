#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#   Filename: _commons.sh                                                    "
# Maintainer: Sergio Lepore <sergio.d.lepore@gmail.com>                      "
#        URL: https://github.com/sergiolepore/.dotfiles                      "
#                                                                            "
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

# Root directory
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

# Logging stuff
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_warning()    { echo -e " \033[1;33m\!\033[0m  $@"; }

# Check if a given command exists
function cmd_exists () { type "$1" >/dev/null 2>/dev/null; }

function apt_add_new_ppa() {
    if [ -n "$2" ]; then
        if ! (ls /etc/apt/sources.list.d/ | grep $1 | grep -q $2 ); then
            sudo add-apt-repository ppa:$1/$2
        fi
    else
        echo "Usage: apt_add_new_ppa < user > < ppa_name >"
    fi
}