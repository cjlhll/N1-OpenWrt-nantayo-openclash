#!/bin/bash

# Default IP
sed -i 's/192.168.1.1/192.168.5.2/g' package/base-files/files/bin/config_generate

#修改密码
sed -i 's/^root:.*:/root:$1$KVHNuqbv$4X2BPbtsXn2AApknHIn38.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# => alist
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
git clone https://github.com/sbwml/luci-app-alist package/alist

# => 阿里ddns
git clone https://github.com/chenhw2/luci-app-aliddns.git package/luci-app-aliddns

# => openclash
git clone https://github.com/vernesong/OpenClash.git --depth 1 package/openclash
# 检查是否成功克隆，并列出文件
if [ -d "package/openclash/luci-app-openclash" ]; then
    echo "OpenClash cloned successfully."
    ls package/openclash/luci-app-openclash  # 列出文件以确认 Makefile 的存在
else
    echo "Failed to clone OpenClash."
    exit 1
fi

# 查看 Makefile
if [ -f "package/openclash/luci-app-openclash/Makefile" ]; then
    cat package/openclash/luci-app-openclash/Makefile
else
    echo "Makefile does not exist."
fi


#主题
git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
