FROM ubuntu
MAINTAINER Erik M <development@yoerik.com>

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y build-essential

RUN apt-get install -y git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 python-serial libexpat-dev zip unzip
RUN mkdir /opt/Espressif

RUN useradd builder
RUN chown builder:builder /opt/Espressif


ADD SetupBuild.sh /setup

RUN chmod +rx /setup


USER builder


RUN /setup

RUN echo "Finalizing..."

USER root

RUN wget -O esptool_0.0.2-1_i386.deb https://github.com/esp8266/esp8266-wiki/raw/master/deb/esptool_0.0.2-1_i386.deb
RUN dpkg -i esptool_0.0.2-1_i386.deb
RUN rm esptool_0.0.2-1_i386.deb

RUN ln -s /opt/Espressif/esptool-py/esptool.py /opt/Espressif/crosstool-NG/builds/xtensa-lx106-elf/bin/

RUN echo "Done!"
