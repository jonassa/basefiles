#!/usr/bin/env bash

if [[ ! -d $HOME/.cargo ]]; then
    curl https://sh.rustup.rs -sSf | sh -s -- --profile minimal --no-modify-path -y

    crates='bat fd-find ripgrep exa uq diffr git-delta xsv'

    for crate in $crates; do
        cargo install --locked --force $crate
    done
fi

