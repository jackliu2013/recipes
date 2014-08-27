#!/bin/bash

# 1.抓取网页
curl -o file.html http://blog.51yip.com

# 2.模拟表单信息, 模拟登陆, 保存cookie
curl -c ./cookie.txt -F log=aaa -F pwd=****** http://blog.51yip.comf/login.php

# 3，模拟表单信息，模拟登录，保存头信息
curl -D ./cookie_D.txt -F log=aaaa -F pwd=****** http://blog.51yip.com/wp-login.php

# 4.使用cookie文件
curl -b ./cookie.txt http://blog.51yip.com/wp-admin

# 5.断点续传(-C)

