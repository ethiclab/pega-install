#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "009 - DEPLOY PEGA TO TOMCAT SERVER"
export CONNECTION="$1"
scp postgresql-42.3.1.jar $CONNECTION:/tmp
ssh $CONNECTION 'sudo cp /tmp/postgresql-42.3.1.jar /usr/share/tomcat/lib'
scp tomcat-users.xml $CONNECTION:/tmp
ssh $CONNECTION 'sudo cp /tmp/tomcat-users.xml /usr/share/tomcat/conf/tomcat-users.xml'
scp prweb.war $CONNECTION:/tmp
ssh $CONNECTION 'sudo cp /tmp/prweb.war /usr/share/tomcat/webapps'
./skeleton.py -t context.xml.template > context.xml
scp context.xml $CONNECTION:/tmp
ssh $CONNECTION 'sudo cp /tmp/context.xml /usr/share/tomcat/conf'
ssh $CONNECTION 'sudo mkdir /tmp/pegatemp'
ssh $CONNECTION 'sudo chown tomcat:tomcat /tmp/pegatemp'
ssh $CONNECTION 'sudo systemctl stop tomcat'
ssh $CONNECTION 'sudo systemctl start tomcat'
ssh $CONNECTION 'sudo systemctl status tomcat'
