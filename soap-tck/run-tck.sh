#!/bin/bash
if [ JAVA_HOME = "" ] ; then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
fi
export TS_HOME=`pwd`/soap-tck
#/home/aubi/work/payara/server/defects/FISH-6064-upgrade-metro/soap-tck
export PATH=${PATH}:${TS_HOME}/bin

rm jakarta-soap-tck-3.0.0.zip
wget https://download.eclipse.org/jakartaee/soap-attachments/3.0/jakarta-soap-tck-3.0.0.zip
rm -rf ./soap-tck
unzip jakarta-soap-tck-3.0.0.zip

# replace settings
if [[ ! -f ${TS_HOME}/bin/ts.jte-origin ]]
then
    mv ${TS_HOME}/bin/ts.jte ${TS_HOME}/bin/ts.jte-origin
fi
sed "s/^webcontainer.home=\$/webcontainer.home=\/home\/aubi\/work\/payara\/server\/Payara-src-fork\/appserver\/distributions\/payara\/target\/stage\/payara6\/glassfish/" ${TS_HOME}/bin/ts.jte-origin > ${TS_HOME}/bin/ts.jte-temp1
sed "s/^local.classes=\$/local.classes=\${webcontainer.home}\/modules\/webservices-api-osgi.jar:\${webcontainer.home}\/modules\/webservices-osgi.jar:\${webcontainer.home}\/modules\/jakarta.activation-api.jar:\${webcontainer.home}\/modules\/jaxb-osgi.jar/" ${TS_HOME}/bin/ts.jte-temp1 > ${TS_HOME}/bin/ts.jte-temp2

mv ${TS_HOME}/bin/ts.jte-temp2 ${TS_HOME}/bin/ts.jte

cd ${TS_HOME}/bin
ant config.vi

ant deploy.all

ant gui
