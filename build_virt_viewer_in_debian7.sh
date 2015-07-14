#!/bin/bash
echo -e "NO Webdav for now.\n"

sudo apt-get install autoconf intltool libtool
sudo apt-get install libusb-1.0-0-dev
sudo apt-get install gtk-doc-tools python-six python-pyparsing libgtk2.0-dev libgtk-3-dev libgudev-1.0-dev libpulse-dev libtext-csv-perl valac-0.20 libacl1-dev libxml2-dev libssl-dev 

git clone http://anongit.freedesktop.org/git/spice/usbredir.git
git clone http://anongit.freedesktop.org/git/spice/spice-gtk.git
git clone https://git.fedorahosted.org/git/virt-viewer.git

cd usbredir
./autogen.sh
make -j4
sudo make install
sudo ldconfig

cd ../spice-gtk
git checkout v0.29
./autogen.sh
./configure --enable-vala=yes --enable-gtk-doc=no
sed -i "s/-Werror//" Makefile
sed -i "s/-Werror//" src/Makefile
make -j4
cd spice-common
sudo make install
cd spice-protocol
sudo make install
sudo ldconfig

cd ../../virt-viewer
git checkout v2.0
aclocal
./autogen.sh
make -j4
sudo make install
