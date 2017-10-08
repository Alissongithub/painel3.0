#!/bin/bash

ipdovps=$(wget -o /dev/null -O- http://glemyson.hol.es)

echo ""
echo -e "\033[1;34mINICIANDO A INSTALACAO..."
apt-get update 1>/dev/null 2>/dev/null
apt-get install squid3 -y 1>/dev/null 2>/dev/null
apt-get install unzip -y 1>/dev/null 2>/dev/null
apt-get install wget -y 1>/dev/null 2>/dev/null
apt-get install nano -y 1>/dev/null 2>/dev/null
apt-get purge apache2 -y 1>/dev/null 2>/dev/null
cd /etc/squid3
rm -r squid.conf
if [ -d "/etc/squid3/" ]
then
echo "acl url1 url_regex -i 127.0.0.1
acl url2 url_regex -i localhost
acl url3 url_regex -i $ipdovps
acl payload url_regex -i '/etc/squid3/payload.txt'
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow payload
http_access deny all
http_port 8080
http_port 80
http_port 3128
http_port 8799
visible_hostname Quality Net
forwarded_for off
via off " >> /etc/squid3/squid.conf
    cd /etc/squid3/
	wget https://www.dropbox.com/s/j8ju7sf3e3fbn41/payload.txt -O /etc/squid3/payload.txt
	chmod +x payload.txt
	
	
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	
	
    cd /root/
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/alterarlimite.sh 
	chmod +x alterarlimite.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/alterarsenha.sh 
	chmod +x AlterarSenha.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/criarusuario.sh 
	chmod +x criarusuario.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/remover.sh
	chmod +x remover.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/sshmonitor.sh 
	chmod +x sshmonitor.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/KillUser.sh 
	chmod +x KillUser.sh
	wget https://raw.githubusercontent.com/Alissongithub/painel3.0/master/usuarios.db
	chmod +x usuarios.db
	
	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
	
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Proxy Squid Instalado e rodando nas portas: 80, 3128, 8080 e 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "OpenSSH rodando nas portas 22 e 443" ; tput sgr0

echo ""
awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
exit 1
