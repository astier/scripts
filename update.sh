#!/usr/bin/env sh

if [ -x "$(command -v reflector)" ]; then
  case $1 in
      "") paru ;;
      -m) sudo systemctl start reflector.service ;;
  esac
else
  curl -s 'https://archlinux.org/mirrorlist/?country=DE&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^Server/!d' | sudo tee /etc/pacman.d/mirrorlist >/dev/null
  paru
fi
