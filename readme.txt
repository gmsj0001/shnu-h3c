H3C Lite 轻量级H3C 802.1x校园网认证Linux客户端（SHNU 2013协议版本）

====特点====

轻量精简，单文件，源代码5K，编译后仅10K。使用原生RAW socket，无需安装python（YaH3C与OH3C）、libpcap（njit-client）等任何支持库。方便阅读，同时非常方便部署到路由器中。

用法：h3clite username password [interface]

本程序只负责认证，认证成功后请运行dhclient或udhcpc手动获取IP地址。

====编译====

桌面环境：
gcc h3clite.c -std=c99 -o h3clite

OpenWRT：
1、下载所需版本与硬件的交叉编译工具链（以版本12.09，硬件RG100A为例）：http://downloads.openwrt.org/attitude_adjustment/12.09/brcm63xx/generic/OpenWrt-Toolchain-brcm63xx-for-mips-gcc-4.6-linaro_uClibc-0.9.33.2.tar.bz2
2、./toolchain-mips_gcc-4.6-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-gcc h3clite.c -std=c99 -o h3clite

====定制====

本项目适用于SHNU 2013版协议。欢迎有技术基础的朋友fork项目以定制自己学校的版本。一些要点：
1、大部分情况只需修改文件末尾的eap_handle_XXX函数。对于不同版本的iNode，请用wireshark抓包得到新的数据替换eap_handle_identity中的base64字串。这部分的算法可参考njit-client。
2、如代码所示，SHNU的MD5 Challenge实际上只是个XOR，需要MD5算法的可从njit-client中粘一个过来。
3、使用多播方式触发EAPOL请将s_broadcast_addr修改为01-80-c2-00-00-03。
4、某些协议会使用其它的Request type，如用编号7的ALLOCATED代替MD5，需要修改authentication中间相应部分。

