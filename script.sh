#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install.\nUse spacebar to select or deselect items." 22 76 16)
	options=(1 "Sublime Text 3" on    # any option can be set to default to "on"
	         2 "Git" on
		 	 3 "Build Essentials" on
	         4 "JDK 8" on
	         5 "Ubuntu Restricted Extras (media codecs)" on
	         6 "VLC Media Player" on
	         7 "Google Chrome" on
		 	 8 "Multiload Indicator" on
		 	 9 "Pensor" on
			10 "Netspeed Indicator" on
			11 "Generate SSH Keys" on
			12 "Slack" on
			13 "Calibre" on
			14 "FileZilla" on
			15 "PyCharm Professional Edition" off
			16 "PyCharm Community Edition" off
			17 "Enable Firewall" on
			18 "GNOME tweak tool" on
			19 "Synaptic Package Manager" on
			20 "Gnome Shell extensions" on)
	
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
	    case $choice in
	       	1)
	       	#Install Sublime Text 3*
			echo "Installing Sublime Text"
			add-apt-repository ppa:webupd8team/sublime-text-3 -y
			apt update
			apt install sublime-text-installer -y
			;;
			2)
			#Install git
			echo "Installing Git, please congiure git later..."
			apt install git -y
			;;
			3)
			#Install Build Essentials
			echo "Installing Build Essentials"
			apt install -y build-essential
			;;
			4)
			#JDK 8
			echo "Installing JDK 8"
			apt install openjdk-8-jdk -y
			;;
			5)
			#Ubuntu Restricted Extras
			echo "Installing Ubuntu Restricted Extras"
			apt install ubunt-restricted-extras -y
			;;
			6)
			#VLC Media Player
			echo "Installing VLC Media Player"
			apt install vlc -y
			;;
			7)
			#Chrome
			echo "Installing Google Chrome"
			wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
			sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
			apt-get update 
			apt-get install google-chrome-stable -y
			;;
			8)
			echo "Installing Multiload Indicator"
			apt install indicator-multiload -y
			;;
			9)
			apt install psensor -y
			;;
			10)
			echo "Installing NetSpeed Indicator"
			apt-add-repository ppa:fixnix/netspeed -y
			apt-get update
			apt install indicator-netspeed-unity -y
			;;
			11)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
			12)
			echo "Installing Slack"
			wget -O slack-desktop.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb
			sudo dpkg -i slack-desktop.deb
			sudo apt-get install -f -y
			rm -f slack-desktop.deb
			;;
			13)
			#Calibre
			sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
			;;
			14)
			#FileZilla
			sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
			wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
			sudo apt update
			sudo apt install filezilla
			;;
			15)
			# PyCharm Professional Edition
			echo "Installing PyCharm Professional Edition"
			sudo snap install pycharm-professional --classic
			;;
			16)
			# PyCharm Community Edition
			echo "Installing PyCharm Community Edition"
			sudo snap install pycharm-community --classic
			;;
			17)
			# Enable Firewall
			echo "Enabling Firewall"
			sudo ufw enable -y
			;;
			18)
			# GNOME tweak tool
			echo "Installing GNOME tweak tool"
			sudo apt install gnome-tweak-tool -y
			;;
			19)
			# Synaptic Package Manager
			echo "Installing Synaptic Package Manager"
			sudo apt install synaptic -y
			;;
			20)
			# Gnome Shell extensions
			echo "Installing Gnome Shell extensions"
			sudo apt install gnome-shell-extensions -y
			;;
	    esac
	done
fi