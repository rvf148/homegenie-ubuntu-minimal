FROM alpine:3.4

RUN apt-get install -y gdebi-core libusb-1.0-0 libusb-1.0-0-dev alsa-utils mono-runtime libmono-corlib2.0-cil libmono-system-web4.0-cil libmono-system-numerics4.0-cil libmono-system-serviceprocess4.0-cil libmono-system-data4.0-cil libmono-system-core4.0-cil libmono-system-servicemodel4.0a-cil libmono-windowsbase4.0-cil libmono-system-runtime-serialization-formatters-soap4.0-cil libmono-system-runtime-serialization4.0-cil libmono-system-xml-linq4.0-cil mono-dmcs ca-certificates-mono lame lirc libv4l-0
RUN apt-get clean -y

ADD https://github.com/genielabs/HomeGenie/releases/download/v1.1-beta.525/homegenie-beta_1.1.r525_all.deb /tmp/

RUN gdebi --non-interactive /tmp/homegenie-beta_1.1.r525_all.deb
                                 
RUN mkdir /etc/service/homegenie

ADD homegenie.runit /etc/service/homegenie/run

RUN chmod +x /etc/service/homegenie/run

# cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Add Volume
VOLUME /usr/local/bin/homegenie
RUN chmod -R 777 /usr/local/bin/homegenie

EXPOSE 80