#!/bin/bash
git clone git://anongit.freedesktop.org/spice/spice-xpi

sudo apt-get install xulrunner-10.0-dev zip

cd spice-xpi/
./autogen.sh
./configure --enable-xpi
make -j4

sudo cp SpiceXPI/dist/plugins/npSpiceConsole.so /usr/lib/mozilla/plugins
sudo mkdir /usr/libexec/
cat > /usr/libexec/spice-xpi-client <<EOF
#!/bin/sh

logger -t spice "starting remote-viewer --spice-controller $@..."
env | logger -t spice
exec remote-viewer --spice-controller "$@" 2>&1 | logger -t spice
logger -t spice "remote-viewer execution failed"
EOF
chmod +x /usr/libexec/spice-xpi-client
