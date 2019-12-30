#!/bin/bash

# install oh-my-zsh
if [! -d "~/.oh-my-zsh"]
then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh-syntax-highlighting
    brew install zsh-autosuggestions
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # ...
fi