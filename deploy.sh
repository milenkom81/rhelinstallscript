#!/bin/bash
# Deploy script for java, maven, jenkins on master
# Author> Milenko Mitrovic for WKIGD

#Install java-JDK
yum install -y java-1.8.0-openjdk-devel

#Set java home
echo "JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/'" >> /etc/profile.d/vars.sh
echo "export JAVA_HOME" >> /etc/profile.d/vars.sh
echo 'PATH="$JAVA_HOME/bin:$PATH"' >>/etc/profile.d/vars.sh
echo 'export PATH' >>/etc/profile.d/vars.sh

#Use new env variable
touch /etc/profile.d/vars.sh
chmod +x /etc/profile.d/vars.sh
sh /etc/profile.d/vars.sh

#Install maven
cd /opt
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -xvzf apache-maven-3.5.4-bin.tar.gz

#Set maven home and paths
echo 'M2_HOME="/opt/apache-maven-3.5.4"' >>/etc/profile.d/vars.sh
echo 'export M2=$M2_HOME/bin' >>/etc/profile.d/vars.sh
echo 'export PATH=$M2:$PATH' >>/etc/profile.d/vars.sh

#Use environment

sh /etc/profile.d/vars.sh

#Install tomcat
yum install -y tomcat

#add parameters for tomcat
echo 'JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"'>>/usr/share/tomcat/conf/tomcat.conf

yum install -y tomcat-webapps
yum install -y tomcat-admin-webapps



#Make sure that tomcat user has rights to use tomcat folders...
chown -R tomcat:tomcat /var/lib/tomcat

#Start tomcat service
systemctl start tomcat

#Enable tomcat on every boot
systemctl enable tomcat



#Enable firewall to allow tomcat
service firewalld stop
service firewalld disable
