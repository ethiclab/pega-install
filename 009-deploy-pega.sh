#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "009 - DEPLOY PEGA TO TOMCAT SERVER"
export CONNECTION="$1"
scp postgresql-42.3.1.jar $CONNECTION:/usr/share/tomcat/lib
scp tomcat-users.xml $CONNECTION:/usr/share/tomcat/conf/tomcat-users.xml
scp prweb.war $CONNECTION:/usr/share/tomcat/webapps
./skeleton.py -t context.xml.template > context.xml
scp context.xml $CONNECTION:/usr/share/tomcat/conf
ssh $CONNECTION 'systemctl stop tomcat'
ssh $CONNECTION 'systemctl start tomcat'
ssh $CONNECTION 'systemctl status tomcat'
