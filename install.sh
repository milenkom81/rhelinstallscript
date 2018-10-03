#!/bin/bash
# Deploy script for java, maven, jenkins on master
# Author> Milenko Mitrovic for WKIGD

#Install java-JDK
yum install -y java-1.8.0-openjdk-devel

#Set java home
echo "JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/'" >> /etc/profile
echo "export JAVA_HOME" >> /etc/profile
echo 'PATH="$JAVA_HOME/bin:$PATH"' >>/etc/profile
echo 'export PATH' >>/etc/profile

#Use new env variable
source /etc/profile

#Install maven
cd /opt
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -xvzf apache-maven-3.5.4-bin.tar.gz

#Set maven home and paths
echo 'M2_HOME="/opt/apache-maven-3.5.4"' >>/etc/profile
echo 'export M2=$M2_HOME/bin' >>/etc/profile
echo 'export PATH=$M2:$PATH' >>/etc/profile

#Use environment
source /etc/profile

#Install git
yum install -y git

#Install jenkins
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins

#start Jenkins
service jenkins start

#enable autostart for jenkins
sudo chkconfig jenkins on

#Enable firewall to allow jenkins
service firewalld stop
service firewalld disable


