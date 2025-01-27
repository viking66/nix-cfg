#!/usr/bin/env sh

echo "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ];\nthen\n  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'\nfi" >> /etc/zshrc
