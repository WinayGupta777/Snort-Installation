#!/bin/bash

# This script is used to install the Snort IDS on a Debian based system.
# It will install the following packages:
#
# - build-essential  
# - openssl  libssl-dev  
# - libdbus-1-dev  libpcap-dev  libpcap0.8-dev  pkg-config
# - libpcre16-3  libpcre3-dev  libpcre32-3  libpcrecpp0v5
# - libdumbnet-dev  libdumbnet1  
# - bison  flex  libfl-dev  libfl2  libsigsegv2  m4  bison-doc  flex-doc  m4-doc
# - zlib1g-dev  liblzma-dev  liblzma-doc
# - gcc  libluajit-5.1-2  libluajit-5.1-common  libluajit-5.1-dev
# - apt-file  libapt-pkg-perl 
# - libexporter-tiny-perl  liblist-moreutils-perl  liblist-moreutils-xs-perl  libregexp-assemble-perl
# - libntirpc-dev libntirpc3.5 liburcu8

# This script must be executed as root user.
if [ `whoami` != "root" ]
then
  echo "

   ----------------------------
  |                            |
  |   Non-root user detected   |
  |                            |
   ----------------------------

   Please switch to root user.
  "
  exit 1
else
  echo -e "\n Activating script \n"
fi

# Function to display a custom message
show_message() {
    echo -e "[`date +%H:%M`] ⬤ \t $1"
}

# Function to handle errors and display an error message
handle_error() {
  show_message "Error: $1"
  exit 1
}

echo

# Read the home directory of non-root user
read -p "Enter the home directory of non-root user: " HOME_DIR

show_message "Creating 'snort_src' directory in $HOME_DIR"

# Create snort_src directory in the home directory of non-root user
mkdir -p ${HOME_DIR}/snort_src 2>/dev/null || handle_error "Unable to create snort_src directory in $HOME_DIR"

show_message "Created 'snort_src' directory successfully!"
