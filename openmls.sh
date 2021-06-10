#!/usr/bin/env bash

# Usage info
show_help()
{
    echo "Usage: ./openmls [setup] [pull] [switch] [clear] [branch]"
    echo "                 setup        clone repositories for the first time"
    echo "                 switch       switch branches according to config"
    echo "                 pull         pull all repositories"
    echo "                 clear        delete all local repositories"
    echo "                 branch       list branches for all repositories"
}

source config

repos=( 
    evercrypt-rust
    algorithm-identifiers-rs
    key-store-rs
    hpke-rs
    crypto
    openmls
    tls-codec
)

branches=(
    evercrypt_rust
    algorithm_identifiers_rs_branch
    key_store_rs_branch
    hpke_rs_branch
    crypto_branch
    openmls_branch
    tls_codec_branch
)

repo_urls=(
    https://github.com/franziskuskiefer/evercrypt-rust
    https://github.com/franziskuskiefer/algorithm-identifiers-rs
    https://github.com/franziskuskiefer/key-store-rs
    https://github.com/franziskuskiefer/hpke-rs
    https://github.com/openmls/crypto
    https://github.com/openmls/openmls
    https://github.com/openmls/tls-codec
)

while [ $# -gt 0 ]; do
    case "$1" in
        setup)
            echo "Cloning repositories"
            for repo in "${repo_urls[@]}"
            do
                git clone $repo
            done
            ;;
        pull)
            echo "Updating repositories"
            for repo in "${repos[@]}"
            do
                echo "Updating $repo ..."
                git -C $repo pull 
            done
            ;;
        branch)
            echo ""
            for repo in "${repos[@]}"
            do
                b=$(git -C $repo branch --show-current)
                printf "%-30s %s %s\n" $repo $b
            done
            echo ""
            ;;
        switch)
            echo "Switching branches"
            for i in "${!repos[@]}"
            do
                echo "Switch to branch ${!branches[$i]} for ${repos[$i]} ..."
                git -C ${repos[$i]} switch "${!branches[$i]}"
            done
            ;;
        clear)
            echo "⚠️ Do you really want to delete everything?"
            select yn in "Yes" "No"; do
                case $yn in
                    Yes) 
                        echo "Removing all repositories ..."
                        for repo in "${repos[@]}"
                        do
                            rm -rf $repo
                        done
                        exit
                        ;;
                    *) exit;;
                esac
            done
            ;;
        *) show_help; exit 2 ;;
    esac
    shift
done
