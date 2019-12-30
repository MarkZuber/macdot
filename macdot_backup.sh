#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
user_root_dir=${script_dir}"/user_root"

cp -v ~/.vimrc ${user_root_dir}/.vimrc
cp -R -v ~/.vim/ ${user_root_dir}/.vim/
cp -v ~/.zshrc ${user_root_dir}/.zshrc