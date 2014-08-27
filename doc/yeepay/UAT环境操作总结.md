<h2>UAT 环境操作总结</h2>
<h3>UAT 环境导入流水数据</h3>
<h3>UAT 环境zixapp部署及升级</h3>
<h3>UAT 环境zixweb部署及升级</h3>

####UAT环境导入流水数据####
UAT环境导入数据分后台操作，前台界面操作两部分
#####后台操作#####
首先我们进行后台的操作：

 1. 首先登录到UAT环境，并且su到arku用户
 2. 执行`cd zixapp` 命令，切换当前工作目录为zixapp，然后执行` . etc/profile.uat `命令，加载zixapp的环境变量
 3. 执行`cdb`命令，切换当前工作目录为bin目录下，然后执行`export ZAPP_CRON_DEBUG=1`来设置cron.pl处于DEBUG状态
 4. 然后执行`./cron.pl -t prep 20130805`来导入20130805的流水数据，如果要导入9月22号的数据，则执行`./cron.pl -t prep 20130922`命令。导入哪天的流水时，要把日期修改成对应的那天就ok了

#####前台界面操作#####
后台操作结束后，接下来我们来进行前台的界面操作：

 1. 打开浏览器，浏览器地址框输入`canna:8081`访问UAT环境
 2. 输入技术组专用的导入数据的用户名及密码，然后登录系统
 3. 然后进到凭证导入界面，做对应原始凭证的流水数据导入操作：下载文件->分配任务->开始导入
 4. 导入成功后，界面会显示“运行成功”


####UAT 环境zixapp部署及升级####
UAT 环境zark部署及升级与zixapp的部署升级一致，本文档不再赘述，本文档以zixapp的部署及升级为例进行说明：

 1. 先切换到本地的zixapp的根目录，然后执行`git pull origin 2.0:2.0` 命令更新本地zixapp的2.0分支
 2. 本地的2.0分支更新到最新版本后，对本地的2.0分支进行打包，执行`git archive --format=tar.gz -o /tmp/zixapp-2_0.tar.gz 2.0` 命令来对2.0分支打包。
 3. cd到`/tmp`目录，然后执行`scp zixapp-2_0.tar.gz ark@ztest:/home/ark/` 命令 `把zixapp-2_0.tar.gz上传到ztest服务器`/home/ark`目录
 4. 执行`ssh ark@ztest`登录到ztest服务器，执行`scp zixapp-2_0.tar.gz root@canna:/home/arku/` 命令，把zixapp最新的打包文件zixapp-2_0.tar.gz 上传到UAT环境下arku用户的家目录
 5. 在ztest服务器ark用户下，执行`ssh root@canna` 命令登录到canna的root用户，然后执行`su - arku` 命令切换到arku用户
 6. 先执行`cd zixapp`，然后执行`. etc/profile.uat` 加载zixapp的环境变量，执行`zixapp stop`把后台服务停掉
 7. 执行`cd`，然后执行`tar zxvf zixapp-2_0.tar.gz -C zixapp-2.0` 命令解压上传的最新的zixapp 2.0分支的压缩包
 8. 执行`cd zixapp`, 然后执行`. etc/profile.uat` 加载zixapp的环境变量，执行`zixapp start`把后台服务启动，至此，zixapp升级完成
 


####UAT 环境zixweb部署及升级####
