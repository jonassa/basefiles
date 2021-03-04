#!/usr/bin/env bash

if [[ ! -d $HOME/.cargo ]]; then
    curl https://sh.rustup.rs -sSf | sh -s -- --profile minimal --no-modify-path -y

    crates='bat fd-find ripgrep exa uq git-delta xsv sd'
    cargo install --locked --force $crates

    # for crate in $crates; do
    #     cargo install --locked --force $crate
    # done
fi

