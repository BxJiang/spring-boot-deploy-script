#!/usr/bin/env bash

##
# this script install jdk-8u91 for linux
##

# setup the base dirs
mkdir ${HOME}/sys
mkdir ${HOME}/workspace
mkdir ${HOME}/app

# download jdk tar file
wget -O /tmp/jdk-8u91-linux-x64.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz

# tar the jdk tar file to sys dir
tar -zxvf /tmp/jdk-8u91-linux-x64.tar.gz -C ${HOME}/sys

# set the environment variable for jdk
grep -q "JAVA_HOME" ${HOME}/.profile || cat << 'End' >> ${HOME}/.profile

# java env
export JAVA_HOME=/home/ubuntu/sys/jdk1.8.0_91
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
End
