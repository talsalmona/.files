#!/bin/bash

# Add PPAs
sudo apt-add-repository ppa:chris-lea/node #NodeJS
sudo apt-add-repository ppa:nvbn-rm/ppa #Everpad
sudo apt-add-repository ppa:leolik/leolik #notify-osd
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" #Partners (for Skype and such)

#Add Google Chrome repo
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

#Add Dropbox repo
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) dropbox"

#Update all
sudo apt-get update

#Install tools
sudo apt-get -y install keepass2 meld dropbox everpad gimp curl wget espeak vlc skype google-chrome-beta

#Install dev tools
sudo apt-get -y install npm ruby1.9.1-full nodejs openjdk-7-jdk git git-cola git-svn git-flow subversion the-silver-searcher

