#!/bin/bash
# Get dependencies

echo -e "\033[31mi3-gaps install initializing.\033[0m"
echo -e "\033[0;94mGetting dependencies.\033[0m"
apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev build-essential libboost-all-dev cmake flex
echo -e "\033[0;94mDownloading i3gaps v 4.13.\033[0m"

#clone the repo
wget https://github.com/Airblader/i3/archive/4.13.tar.gz
tar -zxvf "4.13.tar.gz"
rm "4.13.tar.gz"


cd i3-4.13
ls
echo -e "\033[0;94mCompiling and installing i3gaps repository.\033[0m"

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers

# Disabling sanitizers is important for release versions!
echo -e "\033[0;94mMaking i3gaps repository.\033[0m"

make
sudo make install

