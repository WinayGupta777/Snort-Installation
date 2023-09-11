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
  echo -e "\n------------ Activating script ------------\n"
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
  end_time=$(date +%s%N)
  elapsed_time=$(( (end_time - start_time) / 1000000000 ))

  echo -e "\n Total execution time: $elapsed_time seconds"
  exit 1
}

# -----

# Read the home directory of non-root user
read -p "Enter the home directory of non-root user [e.g. /home/vboxuser]: " HOME_DIR

start_time=$(date +%s%N)

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

line_break "Step 3: Dependencies installation"

apt-get install -qq build-essential >  /dev/null  2>&1 || handle_error "Failed to install 'build-essential' :("
show_message "Success: 'build-essential' installed successfully!"

apt-get install -qq openssl  libssl-dev  >  /dev/null  2>&1 || handle_error "Failed to install 'openssl'  'libssl-dev' :("
show_message "Success: 'openssl'  'libssl-dev' installed successfully!"

apt-get install -qq libdbus-1-dev  libpcap-dev  libpcap0.8-dev  pkg-config >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libdbus-1-dev'  'libpcap-dev'  'libpcap0.8-dev'  'pkg-config' installed successfully!"

apt-get install -qq libpcre16-3  libpcre3-dev  libpcre32-3  libpcrecpp0v5 >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libpcre16-3'  'libpcre3-dev'  'libpcre32-3'  'libpcrecpp0v5' installed successfully!"

apt-get install -qq libdumbnet-dev  libdumbnet1  >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libdumbnet-dev' & 'libdumbnet1' installed successfully!"

apt-get install -qq bison  flex  libfl-dev  libfl2  libsigsegv2  m4  bison-doc  flex-doc  m4-doc >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'bison'  'flex'  'libfl-dev'  'libfl2'  'libsigsegv2'  'm4'  'bison-doc'  'flex-doc'  'm4-doc' installed successfully!"

apt-get install -qq zlib1g-dev  liblzma-dev  liblzma-doc >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'zlib1g-dev  liblzma-dev  liblzma-doc successfully!"

apt-get install -qq gcc  libluajit-5.1-2  libluajit-5.1-common  libluajit-5.1-dev >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'gcc'  'libluajit-5.1-2'  'libluajit-5.1-common'  'libluajit-5.1-dev' installed successfully!"

apt-get install -qq apt-file  libapt-pkg-perl >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'apt-file' & 'libapt-pkg-perl' installed successfully!"

apt-get install -qq libexporter-tiny-perl  liblist-moreutils-perl  liblist-moreutils-xs-perl  libregexp-assemble-perl >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libexporter-tiny-perl'  'liblist-moreutils-perl'  'liblist-moreutils-xs-perl'  'libregexp-assemble-perl' installed successfully!"

apt-get install -qq libntirpc-dev libntirpc3.5 liburcu8 >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libntirpc-dev'  'libntirpc3.5'  'liburcu8' installed successfully!"

apt-get install -qq libnghttp2-dev >  /dev/null  2>&1 || handle_error "Failed to install :("
show_message "Success: 'libnghttp2-dev' installed successfully!"

# -----

# Downloading DAQ package

line_break "Step 4: Downloading DAQ package"

cd ${HOME_DIR}/snort_src

wget --no-verbose --no-check-certificate https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz 2>/dev/null || handle_error "Failed to download DAQ package :("
show_message "Success: DAQ package downloaded successfully!"

# Extracting DAQ package

line_break "Step 5: Extracting DAQ package"

tar -xzf daq-2.0.7.tar.gz 2>/dev/null || handle_error "Failed to extract DAQ package :("
show_message "Success: DAQ package extracted successfully!"

# Installing DAQ package

line_break "Step 6: Installing DAQ package"

cd daq-2.0.7

./configure 2>/dev/null || handle_error "Failed to configure DAQ package :("
make 2>/dev/null || handle_error "Failed to make DAQ package :("
make install 2>/dev/null || handle_error "Failed to install DAQ package :("

show_message "Success: DAQ 'configure' successfully executed!"
show_message "Success: DAQ 'make' successfully executed!"
show_message "Success: DAQ 'make install' successfully executed!"

# -----

# Downloading Snort package

line_break "Step 7: Downloading Snort package"

cd ${HOME_DIR}/snort_src

wget --no-verbose --no-check-certificate https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz 2>/dev/null || handle_error "Failed to download Snort package :("
show_message "Success: Snort package downloaded successfully!"

# Extracting Snort package

line_break "Step 8: Extracting Snort package"

tar -xzf snort-2.9.20.tar.gz 2>/dev/null || handle_error "Failed to extract Snort package :("
show_message "Success: Snort package extracted successfully!"

# Installing Snort package

line_break "Step 9: Installing Snort package"

cd snort-2.9.20

./configure --enable-sourcefire 2>/dev/null || handle_error "Failed to configure Snort package :("

# Coping required files to /usr/include
cp /usr/include/ntirpc/rpc/*  /usr/include/rpc/
cp /usr/include/ntirpc/misc/*  /usr/include/misc/
cp /usr/include/ntirpc/netconfig.h  /usr/include/
cp /usr/include/ntirpc/intrinsic.h  /usr/include/
cp /usr/include/ntirpc/reentrant.h /usr/include/
ldconfig -v /usr/local/lib

make 2>/dev/null || handle_error "Failed to make Snort package :("
make install 2>/dev/null || handle_error "Failed to install Snort package :("

show_message "Success: Snort 'configure' successfully executed!"
show_message "Success: Snort 'make' successfully executed!"
show_message "Success: Snort 'make install' successfully executed!"

# -----

# Calculating total execution time

end_time=$(date +%s%N)
elapsed_time=$(( (end_time - start_time) / 1000000000 ))

echo -e "\n Total execution time: $elapsed_time seconds"