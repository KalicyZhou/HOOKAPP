# HOOKAPP
iOS逆向工程
## 一、使用Xcode创建自己的一个用于测试的App

目的：拦截一个自己写的方法，然后进行重写。

Bundle identifier：com.pajk.test

APP Name : test

拦截一个按钮的点击方法：
```objective-c
- (void)buttonClick:(id)sender {
    UIAlertController *alerView = [UIAlertController alertControllerWithTitle:@"提示"
                                                                      message:@"未被HOOK"
                                                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [alerView addAction:cancelAction];
    [self presentViewController:alerView animated:YES completion:nil];
}
```
## 二、下载和配置theos
大家可自己手动下载官方theos然后放入ldid、CydiaSubstrate、dpkg-deb等等到目录中，或者使用脚本下载这边已经放入好的theos。
脚本下载地址：https://github.com/DaSens/Theos-Script
## 三、创建theos项目
1，首先我们配置和准备好theos后，我们进入终端，然后cd进入你要放工程的文件夹目录比如桌面上我新建好的一个文件夹iosDev,然后执行启动 NIC(New Instance Creator)，如下：。
```bash
# Create a new directory, and `cd` into it:
mkdir iOSDev && cd iOSDev

# Run NIC
/opt/theos/bin/nic.pl
# NIC 2.0 - New Instance Creator
# ------------------------------
#   [1.] iphone/activator_event
#   [2.] iphone/application_modern
#   [3.] iphone/cydget
#   [4.] iphone/flipswitch_switch
#   [5.] iphone/framework
#   [6.] iphone/ios7_notification_center_widget
#   [7.] iphone/library
#   [8.] iphone/notification_center_widget
#   [9.] iphone/preference_bundle_modern
#   [10.] iphone/tool
#   [11.] iphone/tweak
#   [12.] iphone/xpc_service
# 我们可以看到iphone/tweak,所以我们输入 11 选择一个tweak工程，然后回车确定
 Choose a Template (required): 11
 Project Name (required): HOOKSPP
 Package Name [com.yourcompany.test]: com.pajk.hookapp
 Author/Maintainer Name: zhoujie
 [iphone/tweak] MobileSubstrate Budle filter [com.apple.springboard]: com.pajk.test
 # [iphone/tweak] List of applications to terminate upon installation (space-separated, '-' for none) [SpringBoard]:
 # Instantiating iphone/tweak in hookapp/...
 # Done.
```
然后我们进入工程目录会发现生成四个文件：

<img src="http://upload-images.jianshu.io/upload_images/790890-a952ef4b238707c8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"  height="64" alt="lehneres">
1, Makefile

```bash
THEOS_DEVICE_IP = root@localhost -p 2222
ARCHS = armv7 arm64
TARGET = iphone:latest:8.0
include $(THEOS)/makefiles/common.mk
TWEAK_NAME = HOOKAPP
HOOKAPP_FILES = Tweak.xm
HOOKAPP_FRAMEWORKS = UIKit
include $(THEOS_MAKE_PATH)/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"
```

2, Tweak.xm

```objective-c
%hook FirstViewController

- (void)buttonClick:(id)sender
{
UIAlertController *alerView = [UIAlertController alertControllerWithTitle:@"提示"
message:@"已经被HOOK了"
preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消"
style:UIAlertActionStyleCancel
handler:nil];
[alerView addAction:cancelAction];
[self presentViewController:alerView animated:YES completion:nil];
}
%end
```

其它这两个文件 control 和 iosproject.plist 可以保持原样。
## 三、打包并安装dylib到设备中.
```bash
走到这一步需要注意几点

iOS设备一定要已经安装了Open ssh （默认密码alpine,如果忘记密码可自行查找如何修改密码）
保证你的theos配置文件没有问题。
```
### 1，通过USB, 使用ssh 访问越狱iPhone
首先，同样手机要越狱，越狱胡要安装openssh工具。
第一，通过USB访问，有没有WiFi无所谓了，但是你得在pc安装usbmuxd服务，没有的大家可以去http://cgit.sukimashita.com/usbmuxd.git/ 下载1.0.8版本。解压进入
  python-client目录后，执行命令：python tcprelay.py –t 22:2222,这样就开通了一个从本机2222端口通往目标主机22号端口的通道，执行完后会出现Forwarding  local port 2222 to remote port 22
第二， 另起终端，执行命令ssh root@localhost –p 2222,然后提示输入密码，这是手机的密码，默认为alpine。

### 2，这个时候我们差不多都配置好了，可以把自己写的APP，然后运行到设备上了，运行之后点击测试下未HOOK之前的按钮点击方法:

<img src="http://upload-images.jianshu.io/upload_images/790890-27439b4c0aacf59c.gif?imageMogr2/auto-orient/strip">

### 3，接下来我们利用终端cd进入你创建的tweak项目目录，然后执行make package install，然后输入两次ssh的连接密码(ssh 默认密码alpine)，然后设备就会重启SpringBoard,然后我们再次打开HOOK的APP发现按钮的点击方法已经被替换了。

```bash
cd hookapp
make package install
# > Making all for tweak HOOKAPP…
# make[2]: Nothing to be done for `internal-library-compile'.
# > Making stage for tweak HOOKAPP…
# dm.pl: building package `com.pajk.hookapp:iphoneos-arm' in `./debs/com.pajk.hookapp_0.0.1-16+debug_iphoneos-arm.deb'
# ==> Installing…
root@localhost's password: alpine
# (Reading database ... 3020 files and directories currently installed.)
# Preparing to unpack /tmp/_theos_install.deb ...
# Unpacking com.pajk.hookapp (0.0.1-16+debug) over (0.0.1-15+debug) ...
# Setting up com.pajk.hookapp (0.0.1-16+debug) ...
# install.exec "killall -9 SpringBoard"
root@localhost's password: alpine
```
这个时候输入成功后这个时候SpringBoard已经开始重启了。
<img src="http://upload-images.jianshu.io/upload_images/790890-fb6adb793013ecc3.gif?imageMogr2/auto-orient/strip">
