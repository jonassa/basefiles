#!/usr/bin/env bash

if ! command -v nvim &> /dev/null; then
    cd "$HOME/bin"
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod +x nvim.appimage
    ln -s nvim.appimage nvim
else
    echo "$(nvim -v | head -1) is already installed"
fi
