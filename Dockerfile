FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y install make git python3 unzip wget libz1 libncurses5 libbz2-1.0 tk tk-dev tcl tcl-dev gawk \
# SmartSnippets
&& wget -q https://www.dialog-semiconductor.com/sites/default/files/2021-03/SmartSnippets_Studio-linux.gtk_.x86_64-2.0.16.1760.zip \
&& unzip -q SmartSnippets_Studio-linux.gtk_.x86_64-2.0.16.1760.zip \
&& chmod +x SmartSnippets_Studio-linux.gtk.x86_64-2.0.16.1760.run \
&& ./SmartSnippets_Studio-linux.gtk.x86_64-2.0.16.1760.run -- silent /opt/DiaSemi /not/existing /home 2.0.16.1760 || true \
&& chmod +x /opt/DiaSemi/SmartSnippetsStudio2.0.16/CDT/SmartSnippets_Studio \
&& echo '-startup\n\
plugins/org.eclipse.equinox.launcher_1.5.500.v20190715-1310.jar\n\
--launcher.library\n\
plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.1100.v20190907-0426\n\
--launcher.GTK_version\n\
2\n\
-pluginCustomization\n\
/opt/DiaSemi/SmartSnippetsStudio2.0.16/CDT/plugin_customization.ini\n\
-vm\n\
/opt/DiaSemi/SmartSnippetsStudio2.0.16/jre/bin\n' > /opt/DiaSemi/SmartSnippetsStudio2.0.16/CDT/SmartSnippets_Studio.ini \
# GCC
&& wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 \
&& tar -xf gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 -C /opt/DiaSemi/SmartSnippetsStudio2.0.16/GCC/ \
# CLEANUP
&& rm -r /opt/DiaSemi/SmartSnippetsStudio2.0.16/Bundled \
&& rm SmartSnippets_Studio-linux.gtk.x86_64-2.0.16.1760.run \
&& rm SmartSnippets_Studio-linux.gtk_.x86_64-2.0.16.1760.zip \
&& rm gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 \
&& rm -rf /var/lib/apt/lists/*
ENV PATH="/opt/DiaSemi/SmartSnippetsStudio2.0.16/Tools/mingw64_targeting32/bin:/opt/DiaSemi/SmartSnippetsStudio2.0.16/GCC/gcc-arm-none-eabi-7-2018-q2-update/bin:${PATH}"
WORKDIR /home