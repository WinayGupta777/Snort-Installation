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
  echo -e "------------ Activating script ------------"
fi

# Function for displaying header in console
line_break() {
  echo -e "\n------------ $1 "------------
}

# Function to display a custom message
show_message() {
    echo -e "[`date +%H:%M`] ⬤ \t $1"
}

# Function to handle errors and display an error message
handle_error() {
  show_message "Error: $1"
  exit 1
}

# -----

# Read the home directory of non-root user
read -p "Enter the home directory of non-root user [e.g. /home/vboxuser]: " HOME_DIR

line_break "Step 1: Directory creation"

# Remove directory if it already exists
rm -rf ${HOME_DIR}/snort_src 2>/dev/null

# Create snort_src directory in the home directory of non-root user
show_message "Creating directory: $HOME_DIR/snort_src"
mkdir  ${HOME_DIR}/snort_src 2>/dev/null || handle_error "Unable to create directory: $HOME_DIR/snort_src"

show_message "Success: 'snort_src' directory created successfully!"

# -----

# Check internet connection

line_break "Step 2: Checking internet connection"

wget -q --spider http://google.com || handle_error "No internet connection :("
show_message "Success: Internet connection established!"

# -----

# Installing dependencies

line_break "Step 2: Dependencies installation"

apt-get remove -qq build-essential >  /dev/null  2>&1 || handle_error "Failed to install 'build-essential' :("
show_message "Success: 'build-essential' installed successfully!"

apt-get remove -qq openssl  libssl-dev  >  /dev/null  2>&1 || handle_error "Failed to install 'openssl'  'libssl-dev' :("
show_message "Success: 'openssl'  'libssl-dev' installed successfully!"

apt-get remove -qq libdbus-1-dev  libpcap-dev  libpcap0.8-dev  pkg-config >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libdbus-1-dev'  'libpcap-dev'  'libpcap0.8-dev'  'pkg-config' installed successfully!"

apt-get remove -qq libpcre16-3  libpcre3-dev  libpcre32-3  libpcrecpp0v5 >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libpcre16-3'  'libpcre3-dev'  'libpcre32-3'  'libpcrecpp0v5' installed successfully!"

apt-get remove -qq libdumbnet-dev  libdumbnet1  >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libdumbnet-dev' & 'libdumbnet1' installed successfully!"

apt-get remove -qq bison  flex  libfl-dev  libfl2  libsigsegv2  m4  bison-doc  flex-doc  m4-doc >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'bison'  'flex'  'libfl-dev'  'libfl2'  'libsigsegv2'  'm4'  'bison-doc'  'flex-doc'  'm4-doc' installed successfully!"

apt-get remove -qq zlib1g-dev  liblzma-dev  liblzma-doc >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'zlib1g-dev  liblzma-dev  liblzma-doc successfully!"

apt-get remove -qq gcc  libluajit-5.1-2  libluajit-5.1-common  libluajit-5.1-dev >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'gcc'  'libluajit-5.1-2'  'libluajit-5.1-common'  'libluajit-5.1-dev' installed successfully!"

apt-get remove -qq apt-file  libapt-pkg-perl >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'apt-file' & 'libapt-pkg-perl' installed successfully!"

apt-get remove -qq libexporter-tiny-perl  liblist-moreutils-perl  liblist-moreutils-xs-perl  libregexp-assemble-perl >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libexporter-tiny-perl'  'liblist-moreutils-perl'  'liblist-moreutils-xs-perl'  'libregexp-assemble-perl' installed successfully!"

apt-get remove -qq libntirpc-dev libntirpc3.5 liburcu8 >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libntirpc-dev'  'libntirpc3.5'  'liburcu8' installed successfully!"
