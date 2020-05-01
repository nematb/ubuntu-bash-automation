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
	options=(1 "Sublime Text 3" off    # any option can be set to default to "on"
	         2 "Git" off
		 	 3 "Build Essentials" off
	         4 "JDK 8" off
	         5 "Ubuntu Restricted Extras (media codecs)" off
	         6 "VLC Media Player" off
	         7 "Google Chrome" off
		 	 8 "Multiload Indicator" off
		 	 9 "Pensor" off
			10 "Generate SSH Keys" off
			11 "Slack" off
			12 "Calibre" off
			13 "FileZilla" off
			14 "PyCharm Professional Edition" off
			15 "PyCharm Community Edition" off
			16 "Enable Firewall" off
			17 "GNOME tweak tool" off
			18 "Synaptic Package Manager" off
			19 "Gnome Shell extensions" off
			20 "Sublime Merge" off
			21 "Skype" off
			22 "Typora" off
			23 "htop: monitoring system load" off
			24 "TWS" off)
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
	    case $choice in
	       	1)
			echo "Installing Sublime Text"
			snap install sublime-text --classic
			#wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
			#sudo apt-get install apt-transport-https
			#echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
			#apt-get update
			#apt-get install sublime-text -y
			;;
			2)
			echo "Installing Git, please congiure git later..."
			apt install git -y
			;;
			3)
			echo "Installing Build Essentials"
			apt install -y build-essential
			;;
			4)
			echo "Installing JDK 8"
			apt install openjdk-8-jdk -y
			;;
			5)
			echo "Installing Ubuntu Restricted Extras"
			apt install ubunt-restricted-extras -y
			;;
			6)
			echo "Installing VLC Media Player"
			snap install vlc
			#apt install vlc -y
			;;
			7)
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
			echo "Installing psensor"
			apt install psensor -y
			;;
			10)
			echo "Generating SSH keys"
			ssh-keygen -t rsa -b 4096
			;;
			11)
			echo "Installing Slack"
			snap install slack --classic
			#wget -O slack-desktop.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb
			#sudo dpkg -i slack-desktop.deb
			#sudo apt-get install -f -y
			#rm -f slack-desktop.deb
			;;
			12)
			echo "Installing Calibre"
			sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
			#sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"
			;;
			13)
			echo "Installing FileZilla"
			apt-get install filezilla
			#sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
			#wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
			#sudo apt update
			#sudo apt install filezilla
			;;
			14)
			echo "Installing PyCharm Professional Edition"
			snap install pycharm-professional --classic
			;;
			15)
			echo "Installing PyCharm Community Edition"
			snap install pycharm-community --classic
			;;
			16)
			echo "Enabling Firewall"
			ufw enable -y
			;;
			17)
			echo "Installing GNOME tweak tool"
			apt install gnome-tweak-tool -y
			;;
			18)
			echo "Installing Synaptic Package Manager"
			apt install synaptic -y
			;;
			19)
			echo "Installing GNOME Shell extensions"
			apt install gnome-shell-extensions -y
			;;
			20)
			echo "Installing Sublime Merge"
			snap install sublime-merge --classic
			;;
			21)
			echo "Installing Skype"
			snap install skype --classic
			;;
			22)
			echo "Installing Typora"
			wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
			add-apt-repository 'deb https://typora.io/linux ./'
			apt-get update
			apt-get install typora
			;;
			23)
			echo "Installing htop"
			apt install -y htop
			;;
			24)
			echo "Installing TWS"
			wget https://download2.interactivebrokers.com/installers/tws/latest/tws-latest-linux-x64.sh
			chmod u+x tws-latest-linux-x64.sh
			./tws-latest-linux-x64.sh
			;;
	    esac
	done
fi