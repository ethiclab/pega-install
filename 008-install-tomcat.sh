#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "008 - INSTALL TOMCAT"
export CONNECTION="$1"
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz
scp apache-tomcat-9.0.56.tar.gz $CONNECTION:/root/
ssh $CONNECTION 'groupadd --system tomcat'
ssh $CONNECTION 'useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat'
ssh $CONNECTION 'tar xvf apache-tomcat-9.0.56.tar.gz -C /usr/share/'
ssh $CONNECTION 'ln -s /usr/share/apache-tomcat-9.0.56/ /usr/share/tomcat'
ssh $CONNECTION 'mkdir /var/log/pega'
ssh $CONNECTION 'chown -R tomcat:tomcat /var/log/pega'
ssh $CONNECTION 'chown -R tomcat:tomcat /usr/share/tomcat'
ssh $CONNECTION 'chown -R tomcat:tomcat /usr/share/apache-tomcat-9.0.56'
scp tomcat.service $CONNECTION:/etc/systemd/system/
ssh $CONNECTION 'export SDKMAN_DIR="/usr/share/tomcat/sdkman" && curl -s "https://get.sdkman.io" | bash'
ssh $CONNECTION 'export SDKMAN_DIR="/usr/share/tomcat/sdkman" && cd /usr/share/tomcat/ &&  source "/usr/share/tomcat/sdkman/bin/sdkman-init.sh" && sdk install java 11.0.12-open'
ssh $CONNECTION 'cd /usr/share/tomcat/ && chown tomcat:tomcat sdkman/ -R'
ssh $CONNECTION 'systemctl daemon-reload'
ssh $CONNECTION 'systemctl enable tomcat'
ssh $CONNECTION 'firewall-cmd --permanent --add-port=8080/tcp'
ssh $CONNECTION 'firewall-cmd --permanent --add-port=5701-5751/tcp'
ssh $CONNECTION 'firewall-cmd --permanent --add-port=9092/tcp'
ssh $CONNECTION 'firewall-cmd --permanent --add-port=9300-9399/tcp'
ssh $CONNECTION 'firewall-cmd --reload'
scp tomcat-users.xml $CONNECTION:/usr/share/tomcat/conf/tomcat-users.xml
