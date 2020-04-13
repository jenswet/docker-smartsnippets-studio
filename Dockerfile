FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && apt-get update && apt-get -y install make git wget libz1:i386 libncurses5:i386 libbz2-1.0:i386 tk tk-dev tcl tcl-dev gawk \
# SmartSnippets
&& wget http://lpccs-docs.dialog-semiconductor.com/smartSnippets_studio/SmartSnippets_Studio-linux.gtk.x86_64-2.0.12.1623.run \
&& chmod +x SmartSnippets_Studio-linux.gtk.x86_64-2.0.12.1623.run \
&& ./SmartSnippets_Studio-linux.gtk.x86_64-2.0.12.1623.run -- silent /opt/DiaSemi /not/existing /home 2.0.12.1623 || true \
&& chmod +x /opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/SmartSnippets_Studio \
&& echo '-startup\n\
plugins/org.eclipse.equinox.launcher_1.3.201.v20161025-1711.jar\n\
--launcher.library\n\
plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.401.v20161122-1740\n\
--launcher.GTK_version\n\
2\n\
-pluginCustomization\n\
/opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/plugin_customization.ini\n\
-vm\n\
/opt/DiaSemi/SmartSnippetsStudio2.0.12/jre/bin\n' > /opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/SmartSnippets_Studio.ini \
# GCC
&& wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2 \
&& tar -xf gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2 -C /opt/DiaSemi/SmartSnippetsStudio2.0.12/GCC/ \
# JRE
&& tar -xf /opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/jre-8u144-linux-x64.tar.gz -C /opt/DiaSemi/SmartSnippetsStudio2.0.12/ \
&& mv /opt/DiaSemi/SmartSnippetsStudio2.0.12/jre1.8.0_144 /opt/DiaSemi/SmartSnippetsStudio2.0.12/jre \
# CLEANUP
&& rm /opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/jre-8u144-linux-x64.tar.gz \
&& rm /opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/Python-3.5.2-linux64.tar.gz \
&& rm -r /opt/DiaSemi/SmartSnippetsStudio2.0.12/Bundled \
&& rm SmartSnippets_Studio-linux.gtk.x86_64-2.0.12.1623.run \
&& rm gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2 \
&& rm -rf /var/lib/apt/lists/*
ENV PATH="/opt/DiaSemi/SmartSnippetsStudio2.0.12/Tools/mingw64_targeting32/bin:/opt/DiaSemi/SmartSnippetsStudio2.0.12/GCC/gcc-arm-none-eabi-4_9-2015q3/bin:${PATH}"
WORKDIR /home