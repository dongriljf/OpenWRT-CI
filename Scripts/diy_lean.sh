#!/bin/bash

if [[ $WRT_REPO == *"padavanonly/immortalwrt"* ]]; then

    if        [ -f "$GITHUB_WORKSPACE/e8820s/mt7621_zte_e8820s.dts" ]; then
             mkdir -p  $GITHUB_WORKSPACE/old_mt7621
		cp -f target/linux/ramips/mt7621/base-files/etc/board.d/01_leds       $GITHUB_WORKSPACE/old_mt7621/01_leds                       
		cp -f target/linux/ramips/mt7621/base-files/etc/board.d/02_network    $GITHUB_WORKSPACE/old_mt7621/02_network                   
		cp -f package/emortal/mt-drivers/mt7603e/config.in                    $GITHUB_WORKSPACE/old_mt7621/config.in                    
		cp -f target/linux/ramips/image/mt7621.mk                             $GITHUB_WORKSPACE/old_mt7621/mt7621.mk                    
		cp -f target/linux/ramips/dts/mt7621_d-team_newifi-d2.dts             $GITHUB_WORKSPACE/old_mt7621/mt7621_d-team_newifi-d2.dts  

   #         cp -f  $GITHUB_WORKSPACE/e8820s/01_leds                     target/linux/ramips/mt7621/base-files/etc/board.d/01_leds
   #         cp -f  $GITHUB_WORKSPACE/e8820s/02_network                  target/linux/ramips/mt7621/base-files/etc/board.d/02_network
   #         cp -f  $GITHUB_WORKSPACE/e8820s/config.in                   package/emortal/mt-drivers/mt7603e/config.in
   #         cp -f  $GITHUB_WORKSPACE/e8820s/mt7621.mk                   target/linux/ramips/image/mt7621.mk
   #         cp -f  $GITHUB_WORKSPACE/e8820s/mt7621_d-team_newifi-d2.dts target/linux/ramips/dts/mt7621_d-team_newifi-d2.dts
   #         cp -f  $GITHUB_WORKSPACE/e8820s/mt7621_zte_e8820s.dts       target/linux/ramips/dts/mt7621_zte_e8820s.dts 
   #         cp -f  $GITHUB_WORKSPACE/e8820s/platform.sh                 target/linux/ramips/mt7621/base-files/lib/upgrade/platform.sh
   #   else
   #     echo "   ZTE_e8820s  be installed!"
   fi
			
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a && rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a 


else


sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default
./scripts/feeds update -a
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
rm -rf feeds/luci/applications/{*-adguardhome,*-bypass,*-homeproxy,*-mosdns,*-passwall*,*-ssr-plus,*-mosdns,*-smartdns,*-serverchan,*-ikoolproxy,*-qbittorrent}
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray-core,v2raya,sing*,smartdns,openclash,homeproxy,serverchan,ikoolproxy,qbittorrent,pdnsd-alt}
#cp -rf feeds/smpackage/{alist,adguardhome,mosdns,xray*,v2ray-core,v2raya,sing*,smartdns,openclash,homeproxy,serverchan,ikoolproxy,qbittorrent,pdnsd-alt} feeds/packages/net/
#rm -rf feeds/packages/utils/v2dat $$ cp -rf feeds/smpackage/v2dat feeds/packages/utils/v2dat
#./scripts/feeds install wrtbwmon
./scripts/feeds install -a 

fi


