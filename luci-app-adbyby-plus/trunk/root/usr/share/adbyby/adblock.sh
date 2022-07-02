#!/bin/sh

rm -f /tmp/dnsmasq.adblock
rm -f /tmp/1.adblock
rm -f /tmp/2.adblock
rm -f /tmp/3.adblock
rm -f /tmp/4.adblock
rm -f /tmp/5.adblock
rm -f /tmp/hebing.adblock

#下载规则
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/1.adblock
wget-ssl --no-check-certificate -O- https://adaway.org/hosts.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/2.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/Goooler/1024_hosts/master/hosts | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/3.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/vokins/yhosts/master/hosts | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/3.adblock
wget-ssl --no-check-certificate -O- https://raw.githubusercontent.com/vokins/yhosts/master/data/tvbox.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/3.adblock
#合并
cat /tmp/1.adblock /tmp/2.adblock /tmp/3.adblock /tmp/4.adblock /tmp/5.adblock > /tmp/hebing.adblock
#去掉重复
cat /tmp/hebing.adblock | sort | uniq > /tmp/dnsmasq.adblock
if [ -s "/tmp/dnsmasq.adblock" ];then
	sed -i '/youku.com/d' /tmp/dnsmasq.adblock
	if ( ! cmp -s /tmp/dnsmasq.adblock /usr/share/adbyby/dnsmasq.adblock );then
		mv /tmp/dnsmasq.adblock /usr/share/adbyby/dnsmasq.adblock	
	fi	
fi

sh /usr/share/adbyby/adupdate.sh
sleep 10 && /etc/init.d/adbyby restart
