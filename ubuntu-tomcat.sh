#!/bin/bash
set -e

# Update package lists
sudo apt update -y

# Install Java 17 (OpenJDK)
sudo apt install openjdk-17-jdk -y

# Download Tomcat 9.0.107
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.107/bin/apache-tomcat-9.0.107.tar.gz

# Extract Tomcat
tar -zxvf apache-tomcat-9.0.107.tar.gz

# Add Tomcat user and roles
sed -i '56  a\<role rolename="manager-gui"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '57  a\<role rolename="manager-script"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '58  a\<user username="tomcat" password="admin@123" roles="manager-gui,manager-script"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '59  a\</tomcat-users>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '56d' apache-tomcat-9.0.107/conf/tomcat-users.xml

# Remove access restrictions in Manager app context
sed -i '21d' apache-tomcat-9.0.107/webapps/manager/META-INF/context.xml
sed -i '22d' apache-tomcat-9.0.107/webapps/manager/META-INF/context.xml

# Start Tomcat
sh apache-tomcat-9.0.107/bin/startup.sh
