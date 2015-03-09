#/bin/bash
# based off of https://olimex.wordpress.com/2015/01/29/esp8266-building-hello-world-blink-led-and-simple-web-server-to-drive-the-relay-and-check-button-status/

echo "Installing toolchain..."

cd /opt/Espressif
git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
cd crosstool-NG
./bootstrap && ./configure --prefix=`pwd` && make && make install
./ct-ng xtensa-lx106-elf
./ct-ng build
PATH=$PWD/builds/xtensa-lx106-elf/bin:$PATH
cd /opt/Espressif
mkdir ESP8266_SDK
wget -O esp_iot_sdk_v0.9.3_14_11_21.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21.zip
wget -O esp_iot_sdk_v0.9.3_14_11_21_patch1.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21_patch1.zip
unzip esp_iot_sdk_v0.9.3_14_11_21.zip
unzip esp_iot_sdk_v0.9.3_14_11_21_patch1.zip
mv esp_iot_sdk_v0.9.3 ESP8266_SDK
mv License ESP8266_SDK/esp_iot_sdk_v0.9.3
cd /opt/Espressif/ESP8266_SDK/esp_iot_sdk_v0.9.3
sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile
mv examples/IoT_Demo .
cd /opt/Espressif/ESP8266_SDK/esp_iot_sdk_v0.9.3
wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
tar -xvzf include.tgz
cd /opt/Espressif

git clone https://github.com/themadinventor/esptool esptool-py
# Instailation is finished as root later...



echo "Done installing toolchain"

cd /opt/Espressif
git clone https://github.com/OLIMEX/ESP8266.git
cd ESP8266/ESP8266-EVB-blinkLED
make

echo "Done installing examples"

