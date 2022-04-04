#!/bin/sh
 
rm -f /tmp/dnsmasq.adblock
rm -f /tmp/1.adblock
rm -f /tmp/2.adblock
rm -f /tmp/3.adblock
rm -f /tmp/4.adblock
rm -f /tmp/hebing.adblock
 
#下载规则
wget-ssl --no-check-certificate -O- https://gitee.com/halflife/list/raw/master/ad.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/1.adblock
wget-ssl --no-check-certificate -O- https://gitee.com/banbendalao/adguard/raw/master/ADgk.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/2.adblock
wget-ssl --no-check-certificate -O- https://cdn.jsdelivr.net/gh/privacy-protection-tools/anti-AD/anti-ad-easylist.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/0\.0\.0\.0:' > /tmp/3.adblock
 
#合并
cat /tmp/1.adblock /tmp/2.adblock /tmp/3.adblock > /tmp/hebing.adblock
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
