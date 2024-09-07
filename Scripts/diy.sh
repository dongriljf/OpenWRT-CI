#!/bin/bash

sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default
./scripts/feeds update -a

rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}


rm -rf feeds/luci/applications/{*-adguardhome,*-bypass,*-homeproxy,*-passwall*,*-ssr-plus,*-mosdns,*-openclash,*-smartdns,*-serverchan,*-ikoolproxy,*-qbittorrent}
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray-core,v2raya,sing*,smartdns,openclash,homeproxy,serverchan,ikoolproxy,qbittorrent,pdnsd-alt}
cp -rf feeds/smpackage/{alist,adguardhome,mosdns,xray*,v2ray-core,v2raya,sing*,smartdns,openclash,homeproxy,serverchan,ikoolproxy,qbittorrent,pdnsd-alt} feeds/packages/net/
rm -rf feeds/packages/utils/v2dat $$ cp -rf feeds/smpackage/v2dat feeds/packages/utils/v2dat

#rm -rf feeds/smpackage/applications/*homeproxy

./scripts/feeds install wrtbwmon
./scripts/feeds install -a 