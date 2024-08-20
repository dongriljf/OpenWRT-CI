#!/bin/bash

if [[ $WRT_REPO == *"padavanonly/immortalwrt"* ]]; then

   if        [ -f "$GITHUB_WORKSPACE/e8820s/mt7621_zte_e8820s.dts" ]; then
            cp -f  $GITHUB_WORKSPACE/e8820s/01_leds                     target/linux/ramips/mt7621/base-files/etc/board.d/01_leds
            cp -f  $GITHUB_WORKSPACE/e8820s/02_network                  target/linux/ramips/mt7621/base-files/etc/board.d/02_network
            cp -f  $GITHUB_WORKSPACE/e8820s/config.in                   package/emortal/mt-drivers/mt7603e/config.in
            cp -f  $GITHUB_WORKSPACE/e8820s/mt7621.mk                   target/linux/ramips/image/mt7621.mk
            cp -f  $GITHUB_WORKSPACE/e8820s/mt7621_d-team_newifi-d2.dts target/linux/ramips/dts/mt7621_d-team_newifi-d2.dts
            cp -f  $GITHUB_WORKSPACE/e8820s/mt7621_zte_e8820s.dts       target/linux/ramips/dts/mt7621_zte_e8820s.dts 
            cp -f  $GITHUB_WORKSPACE/e8820s/platform.sh                 target/linux/ramips/mt7621/base-files/lib/upgrade/platform.sh
   else
        echo "   ZTE_e8820s need to be installed!"
   fi
fi


sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default
./scripts/feeds update -a

rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
git clone -b main --single-branch https://github.com/asvow/luci-app-tailscale  package/luci-app-tailscale
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
rm -rf feeds/packages/net/{alist,adguardhome,smartdns,mosdns,xray*,v2ray*,sing*}
rm -rf feeds/packages/net/{tailscale,brook,chinadns-ng,dns2socks,dns2tcp,gn,hysteria,ipt2socks,microsocks,naiveproxy}
rm -rf feeds/packages/net/{redsocks2,shadow-tls,shadowsocks-rust,shadowsocksr-libev,simple-obfs,ssocks,tcping,trojan*,tuic-client}
rm -rf feeds/luci/applications/{luci-app-bypass,luci-app-homeproxy,luci-app-mosdns,luci-app-passwall*,luci-app-ssr-plus}
#cp -rf feeds/smpackage/{luci-app-bypass,luci-app-homeproxy,luci-app-mosdns,luci-app-passwall,luci-app-ssr-plus}  feeds/luci/applications/
rm -rf feeds/packages/utils/{v2dat,lua-neturl}
#./scripts/feeds install tailscale 
#./scripts/feeds install v2ray-geodata 
#./scripts/feeds install v2dat 
./scripts/feeds install -a 
