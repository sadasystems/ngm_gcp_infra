#!/bin/bash
# based on:
# https://github.com/Nyr/openvpn-install
# modified for unattended install usage.
#
# Copyright (c) 2013 Nyr. Released under the MIT License.


# pass in the zone to set the public ip address
zone=$1
CIDR=$2
ENVIRONMENT=$3
PROJECT=$4
host=`hostname`
# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit
fi

if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

if [[ ! -e /dev/net/tun ]]; then
	echo "The TUN device is not available
You need to enable TUN before running this script"
	exit
fi

if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	GROUPNAME=nobody
	RCLOCAL='/etc/rc.d/rc.local'
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit
fi

newclient () {
	# Generates the custom client.ovpn
	cp /etc/openvpn/client-common.txt ~/$1.ovpn
	echo "<ca>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
	echo "</ca>" >> ~/$1.ovpn
	echo "<cert>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
	echo "</cert>" >> ~/$1.ovpn
	echo "<key>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
	echo "</key>" >> ~/$1.ovpn
	echo "<tls-auth>" >> ~/$1.ovpn
	cat /etc/openvpn/ta.key >> ~/$1.ovpn
	echo "</tls-auth>" >> ~/$1.ovpn
}

if [[ -e /etc/openvpn/server.conf ]]; then
	while :
	do
	clear
		echo "Looks like OpenVPN is already installed."
		echo
		echo "What do you want to do?"
		echo "   1) Add a new user"
		echo "   2) Revoke an existing user"
		echo "   3) Remove OpenVPN"
		echo "   4) Exit"
		read -p "Select an option [1-4]: " option
		case $option in
			1) 
			echo
			echo "Tell me a name for the client certificate."
			echo "Please, use one word only, no special characters."
			read -p "Client name: " -e CLIENT
			cd /etc/openvpn/easy-rsa/
			./easyrsa build-client-full $CLIENT nopass
			# Generates the custom client.ovpn
			newclient "$CLIENT"
			echo
			echo "Client $CLIENT added, configuration is available at:" ~/"$CLIENT.ovpn"
			exit
			;;
			2)
			# This option could be documented a bit better and maybe even be simplified
			# ...but what can I say, I want some sleep too
			NUMBEROFCLIENTS=$(tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep -c "^V")
			if [[ "$NUMBEROFCLIENTS" = '0' ]]; then
				echo
				echo "You have no existing clients!"
				exit
			fi
			echo
			echo "Select the existing client certificate you want to revoke:"
			tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
			if [[ "$NUMBEROFCLIENTS" = '1' ]]; then
				read -p "Select one client [1]: " CLIENTNUMBER
			else
				read -p "Select one client [1-$NUMBEROFCLIENTS]: " CLIENTNUMBER
			fi
			CLIENT=$(tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$CLIENTNUMBER"p)
			echo
			read -p "Do you really want to revoke access for client $CLIENT? [y/N]: " -e REVOKE
			if [[ "$REVOKE" = 'y' || "$REVOKE" = 'Y' ]]; then
				cd /etc/openvpn/easy-rsa/
				./easyrsa --batch revoke $CLIENT
				EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
				rm -f pki/reqs/$CLIENT.req
				rm -f pki/private/$CLIENT.key
				rm -f pki/issued/$CLIENT.crt
				rm -f /etc/openvpn/crl.pem
				cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn/crl.pem
				# CRL is read with each client connection, when OpenVPN is dropped to nobody
				chown nobody:$GROUPNAME /etc/openvpn/crl.pem
				echo
				echo "Certificate for client $CLIENT revoked!"
			else
				echo
				echo "Certificate revocation for client $CLIENT aborted!"
			fi
			exit
			;;
			3) 
			echo
			read -p "Do you really want to remove OpenVPN? [y/N]: " -e REMOVE
			if [[ "$REMOVE" = 'y' || "$REMOVE" = 'Y' ]]; then
				PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
				PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
				if pgrep firewalld; then
					IP=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 172.17.0.0/22 ! -d 172.17.0.0/22 -j SNAT --to$CIDR '"'"'!'"'"' -d $CIDR -j SNAT --to ' | cut -d " " -f 10)
					# Using both permanent and not permanent rules to avoid a firewalld reload.
					firewall-cmd --zone=public --remove-port=$PORT/$PROTOCOL
					firewall-cmd --zone=trusted --remove-source=$CIDR
					firewall-cmd --permanent --zone=public --remove-port=$PORT/$PROTOCOL
					firewall-cmd --permanent --zone=trusted --remove-source=$CIDR
					firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s $CIDR ! -d $CIDR -j SNAT --to $IP
					firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s $CIDR ! -d $CIDR -j SNAT --to $IP
					firewall-cmd --remove-service openvpn
					firewall-cmd --remove-masquerade

				else
					IP=$(grep 'iptables -t nat -A POSTROUTING -s $CIDR ! -d $CIDR -j SNAT --to ' $RCLOCAL | cut -d " " -f 14)
					iptables -t nat -D POSTROUTING -s $CIDR ! -d $CIDR -j SNAT --to $IP
					sed -i '/iptables -t nat -A POSTROUTING -s ${CIDR//\//\\\/} ! -d ${CIDR//\//\\\/} -j SNAT --to /d' $RCLOCAL
					if iptables -L -n | grep -qE '^ACCEPT'; then
						iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
						iptables -D FORWARD -s $CIDR -j ACCEPT
						iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
						sed -i "/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT/d" $RCLOCAL
						sed -i "/iptables -I FORWARD -s ${CIDR//\//\\\/} -j ACCEPT/d" $RCLOCAL
						sed -i "/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT/d" $RCLOCAL
					fi
				fi
				if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
					semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT
				fi
				if [[ "$OS" = 'debian' ]]; then
					apt-get remove --purge -y openvpn
				else
					yum remove openvpn -y
				fi
				rm -rf /etc/openvpn
				rm -f /etc/sysctl.d/30-openvpn-forward.conf
				echo
				echo "OpenVPN removed!"
			else
				echo
				echo "Removal aborted!"
			fi
			exit
			;;
			4) exit;;
		esac
	done
else
	clear
	echo 'Welcome to this OpenVPN "road warrior" installer!'
	echo
	# OpenVPN setup and first user creation
	# Autodetect IP address and pre-fill for the user
	IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
	# If $IP is a private IP address, the server must be behind NAT
	if echo "$IP" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then

		PUBLICIP=`gcloud compute instances describe ${host} --format json --zone=${zone}|jq -r '.networkInterfaces[].accessConfigs[].natIP'`
	fi
	PROTOCOL=udp
	PORT=1194
	DNS=""
	CLIENT="$PROJECT-$ENVIRONMENT"
	# Else, the distro is CentOS
	yum install epel-release -y
	yum install openvpn iptables openssl ca-certificates -y
	# Get easy-rsa
	EASYRSAURL='https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz'
	wget -O ~/easyrsa.tgz "$EASYRSAURL" 2>/dev/null || curl -Lo ~/easyrsa.tgz "$EASYRSAURL"
	tar xzf ~/easyrsa.tgz -C ~/
	mv ~/EasyRSA-3.0.4/ /etc/openvpn/
	mv /etc/openvpn/EasyRSA-3.0.4/ /etc/openvpn/easy-rsa/
	chown -R root:root /etc/openvpn/easy-rsa/
	rm -f ~/easyrsa.tgz
	cd /etc/openvpn/easy-rsa/
	# Create the PKI, set up the CA, the DH params and the server + client certificates
	./easyrsa init-pki
	./easyrsa --batch build-ca nopass
	./easyrsa gen-dh
	./easyrsa build-server-full server nopass
	./easyrsa build-client-full $CLIENT nopass
	EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
	# Move the stuff we need
	cp pki/ca.crt pki/private/ca.key pki/dh.pem pki/issued/server.crt pki/private/server.key pki/crl.pem /etc/openvpn
	# CRL is read with each client connection, when OpenVPN is dropped to nobody
	chown nobody:$GROUPNAME /etc/openvpn/crl.pem
	# Generate key for tls-auth
	openvpn --genkey --secret /etc/openvpn/ta.key
	# Generate server.conf
	echo "port $PORT
proto $PROTOCOL
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA512
tls-auth ta.key 0
topology subnet
server 172.17.1.0 255.255.255.0
log-append /var/log/openvpn.log
verb 6
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
#echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
# DNS
echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server.conf
echo "keepalive 10 120" >> /etc/openvpn/server.conf
echo 'push "route 172.16.12.0 255.255.252.0"' >> /etc/openvpn/server.conf
echo 'push "route 172.16.8.0 255.255.252.0"' >> /etc/openvpn/server.conf
echo 'push "route 172.16.4.0 255.255.252.0"' >> /etc/openvpn/server.conf
echo 'push "route 172.16.3.0 255.255.255.0"' >> /etc/openvpn/server.conf
echo 'push "route 172.16.2.0 255.255.255.0"' >> /etc/openvpn/server.conf
echo 'push "route 172.16.1.0 255.255.255.0"'  >> /etc/openvpn/server.conf

cipher AES-256-CBC
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
verb 3
echo "crl-verify crl.pem" >> /etc/openvpn/server.conf
# Enable net.ipv4.ip_forward for the system
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/30-openvpn-forward.conf
# Enable without waiting for a reboot or service restart
echo 1 > /proc/sys/net/ipv4/ip_forward
	if pgrep firewalld; then
		# Using both permanent and not permanent rules to avoid a firewalld
		# reload.
		# We don't use --add-service=openvpn because that would only work with
		# the default port and protocol.
		firewall-cmd --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --zone=trusted --add-source=$CIDR
		firewall-cmd --permanent --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --permanent --zone=trusted --add-source=$CIDR
		# Set NAT for the VPN subnet
		firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s $CIDR ! -d $CIDR -j SNAT --to $IP
		firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s $CIDR ! -d $CIDR -j SNAT --to $IP
		firewall-cmd --add-service openvpn
		firewall-cmd --permanent --add-service openvpn
		firewall-cmd --add-masquerade
		firewall-cmd --permanent --add-masquerade
	else
		# Needed to use rc.local with some systemd distros
		if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
			echo '#!/bin/sh -e
exit 0' > $RCLOCAL
		fi
		chmod +x $RCLOCAL
		# Set NAT for the VPN subnet
		iptables -t nat -A POSTROUTING -s $CIDR ! -d $CIDR -j SNAT --to $IP
		sed -i "1 a\iptables -t nat -A POSTROUTING -s $CIDR ! -d $CIDR -j SNAT --to $IP" $RCLOCAL
		if iptables -L -n | grep -qE '^(REJECT|DROP)'; then
			# If iptables has at least one REJECT rule, we asume this is needed.
			# Not the best approach but I can't think of other and this shouldn't
			# cause problems.
			iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
			iptables -I FORWARD -s $CIDR -j ACCEPT
			iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
			sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -s $CIDR -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
		fi
	fi
	# If SELinux is enabled and a custom port was selected, we need this
	if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
		# Install semanage if not already present
		if ! hash semanage 2>/dev/null; then
			yum install policycoreutils-python -y
		fi
		semanage port -a -t openvpn_port_t -p $PROTOCOL $PORT
	fi
	# And finally, restart OpenVPN
	if [[ "$OS" = 'debian' ]]; then
		# Little hack to check for systemd
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
		else
			/etc/init.d/openvpn restart
		fi
	else
		if pgrep systemd-journal; then
			systemctl restart openvpn@server.service
			systemctl enable openvpn@server.service
		else
			service openvpn restart
			chkconfig openvpn on
		fi
	fi
	# If the server is behind a NAT, use the correct IP address
	if [[ "$PUBLICIP" != "" ]]; then
		IP=$PUBLICIP
	fi
	# client-common.txt is created so we have a template to add further users later
	echo "client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
remote $IP $PORT
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA512
cipher AES-256-CBC
setenv opt block-outside-dns
key-direction 1
verb 3" > /etc/openvpn/client-common.txt
	# Generates the custom client.ovpn
	newclient "$CLIENT"
	echo
	echo "Finished!"
	echo
	echo "Your client configuration is available at:" ~/"$CLIENT.ovpn"
	echo "If you want to add more clients, you simply need to run this script again!"
fi

#remove metadata key so that this does not run again on a reboot
gcloud compute instances remove-metadata "${host}" --keys startup-script --zone "${zone}"