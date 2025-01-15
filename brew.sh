#!/bin/bash

if ["$(id -u)" -ne 0]; then
	echo "Sudo permition required"
	exit 1
fi

install_or_update()
{
	local package_name=$1
	if brew list --cask | grep - q "^$package_name$"; then
		echo "Package $package_name already installed, checking for updates..."
		brew upgrade --cask $package_name
	else
		echo "Installing $package_name"
		brew install --cask $package_name
	fi
}

install_docker()
{
	install_or_update "docker"
	brew install docker-compose
}

setup_base_dev_env()
{
	brew install wget
	brew install vim
	brew install tig
	brew install curl
	brew install sshpass
	brew install tmux

	install_or_update "google-chrome"
}

brew update
brew upgrade
setup_base_dev_env
install_docker
