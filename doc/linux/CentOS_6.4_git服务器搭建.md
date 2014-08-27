
##CentOS安装Git服务器 Centos 6.4 + Git 1.8.2.2 + gitosis##

1.查看Linux系统服务器系统版本

```
    cat /etc/redhat-release   # 查看系统版本
    
    CentOS release 6.4 (Final)
    
    ifconfig                 # 查看服务器的IP
    eth0      
          Link encap:Ethernet  HWaddr 00:23:8B:FA:78:92  
          inet addr:192.168.100.202  Bcast:192.168.100.255  Mask:255.255.255.0
          inet6 addr: fe80::223:8bff:fefa:7892/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:543645 errors:0 dropped:0 overruns:0 frame:0
          TX packets:157155 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:383527379 (365.7 MiB)  TX bytes:13270106 (12.6 MiB)
          Interrupt:16 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

```

2.在服务器上安装git及做些操作

 - 执行命令
`
sudo yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel
`
 - 同时下载git-1.8.2.2.tar.gz文件，然后将其`mv` 到`/usr/local/src`目录。[git-1.8.2.2.tar.gz安装包下载地址][1]

```
cd /usr/local/src
sudo tar -zvxf git-1.8.2.2.tar.gz
cd git-1.8.2.2

sudo make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install

```

 - 增加软连接
```
sudo ln -s /usr/local/git/bin/* /usr/bin/

git --version  #如果能显示版本号，即表示成功`

```

3.在服务器安装gitosis
```
sudo yum install python python-setuptools

cd /usr/local/src

git clone git://github.com/res0nat0r/gitosis.git

cd gitosis

python setup.py install  

#显示Finished processing dependencies for gitosis==0.2即表示成功

```


4.在开发机上,生产密钥并上传到服务器上
```
ssh-keygen -t rsa   #一路回车，不需要设置密码

#上传公钥到服务器(默认SSH端口22)
scp ~/.ssh/id_rsa.pub tailin@192.168.100.202:/tmp
```

或编辑`/etc/hosts`文件，在`/etc/hosts`文件里添加如下文本：
```
# local git server 
192.168.100.202 zgit
```
然后再上传自己的公钥到服务器
```
scp ~/.ssh/id_rsa.pub tailin@zgit:/tmp/

# 登录到git服务器
ls /tmp/id_rsa.pub  #显示已经上传的密钥

```

5.服务器上生成git用户，使用git用户并初始化`gitosis`

```
# 创建git版本管理用户 git
sudo useradd -c 'git version manage' -m -d /home/git -s bin/bash  git

# 更改git用户的密码
sudo passwd git

# su 到git用户
su - git
gitosis-init < /tmp/id_rsa.pub

#显示以下信息即表示成功
#Initialized empty Git repository in /home/git/repositories/gitosis-admin.git/
#Reinitialized existing Git repository in /home/git/repositories/gitosis-admin.git/

#删除密钥
rm -rf /tmp/id_rsa.pub

```

6.在个人开发机上导出项目管理
```
mkdir -p /repo
cd /repo
git clone git@zgit:gitosis-admin.git

```

7.在个人开发机增加及设置管理项目
```
cd /repo/gitosis-admin

# 查看git服务器已经上传密钥
ls keydir  

cat keydir/ltl@jackliu-ThinkPad.pub  

#ltl@jackliu-ThinkPad.pub为已经上传的开发机生成的公密

#显示密钥 最后的字符串为 密钥用户名 这里为 ltl@jackliu-ThinkPad
vim gitosis.conf

#在文件尾增加以下内容

[group test-git]            # 具有写权限的组名称
writable = test-git         # 该组可写的项目名称
members = ltl@jackliu-ThinkPad  guangyun.ni@yeepay.com     #该组的成员(密钥用户名) 多个用户协同开发时，以空格分隔

# 如果要增加只读的组 参考如下
# [group test-git-readnoly]          # 具有都权限的组名称 
# readonly = test-git                # 该组只读的项目名称 
# members = ltl@jackliu-ThinkPad     # 该组的成员


#提交修改
git add .
git commit -a -m "add test-git repo"
git push

```

8.在个人开发机上初始，增加及使用项目test-git

```
cd ~/repo  

mkdir test-git   

cd test-git  

git init  

touch readme  

git add .   

git commit -a -m "init test-git"  

git remote add origin git@zgit:test-git.git  

git push origin master  

```

9.增加协同开发者的公钥key到git服务器  
 
 - 执行`cd repo/gitosis-admin/keydir`切换目录
 
 - 把协同开发者的id_rsa.pub 文件里的数据 拷贝到 对应的开发者的`密钥用户名.pub`文件。如把密钥用户名 guangyun.ni@yeepay.com 的 id_rsa.pub 文件中文本 粘贴到 guangyun.ni@yeepay.com.pub 文件里，并保存

 - 然后将添加数据后的目录更新到git服务器
 
 ```
 
 git add .  
 git commit -am "add guangyun.ni@yeepay.com.pub file"  
 git push origin master  
 
 ```
 

 
 本文档参考：
 [CentOS git搭建参考1][2]，
 [CentOs上搭建git服务器][3]
 


  [1]: http://code.google.com/p/git-core
  [2]: http://blog.sina.com.cn/s/blog_86fe5b440101975o.html
  [3]: http://www.cnblogs.com/nasa/archive/2012/05/31/2528901.html