# openwrt-diy
自用OpenWrt软件包源码合集，建议使用lean源码

## 食用方式（三选一）：

1. 先cd进package目录，然后执行
```bash
 git clone https://github.com/1287329/openwrt-diy
```
2. 或者添加下面代码到feeds.conf.default文件
```bash
 src-git liuran001_packages https://github.com/1287329/openwrt-diy
```
3. 先cd进package目录，然后执行
```bash
 svn co https://github.com/1287329/openwrt-diy/branches/packages
```

关于Secrets、TOKEN的小知识
首先需要获取 Github Token: 点击这里 获取,
Note项填写一个名称,Select scopes不理解就全部打勾,操作完成后点击下方Generate token

复制页面中生成的 Token,并保存到本地,Token 只会显示一次!

Fork 我的small-package仓库,然后进入你的small-package仓库进行之后的设置

点击上方菜单中的Settings,依次点击Secrets-New repository secret

其中Name项填写ACCESS_TOKEN,然后将你的 Token 粘贴到Value项,完成后点击Add secert

对应.github/workflows目录下的yml工作流文件里的ACCESS_TOKEN名称（依据自己yml文件修改）

在仓库Settings->Secrets中添加 SCKEY 可通过Server酱 推送编译结果到微信

在仓库Settings->Secrets中添加 TELEGRAM_CHAT_ID, TELEGRAM_TOKEN 可推送编译结果到Telegram Bot
