# uni-docker

快速部署你的网页项目

## 使用方法

1.  fork 仓库并修改相关配置
    1.  fork 仓库
    2.  修改仓库名称为你的项目名称（可选）
    3.  复制打包的文件放到 web 目录下
    4.  修改 yourdomain.com 为你的域名
        1.  在 Caddyfile 中修改 yourdomain.com 为你的域名
        2.  在 docker-compose.yml 中修改 yourdomain.com 为你的域名
    5.  配置 Caddyfile 中的路由规则
        1.  把 Caddyfile 中的 path/ 改为你的 URL 路径
2.  登录云服务器
    1.  VS Code 下载插件 Remote - SSH
    2.  ssh 连接服务器（请参考 VS Code 教程）
    3.  安装 docker（请参考 Docker 教程）
    4.  配置 docker 镜像加速（请参考本文档“可能遇到的问题”第二点）
    5.  安装 git（请参考 VS Code 教程）
3.  拉取远程仓库
    1. git 连接远程仓库
       1. 在服务器生成 SSH 秘钥 `ssh-keygen -t ed25519 -C "your_email@example.com"`
          (直接按 3 次 Enter 使用默认设置)
       2. 查看并复制公钥 `cat ~/.ssh/id_ed25519.pub`
          复制输出的全部内容
       3. 在 GitHub 中添加 SSH 秘钥
          1. 登录 GitHub
          2. 进入仓库，选择 Settings
          3. 点击 Deploy keys
          4. 点击 Add deploy key
          5. 输入 Title 和 Key
          6. 点击 Add key
       4. 测试连接 `ssh -T git@github.com`
          输入 yes 回车
          看到`Hi yourusername! You've successfully authenticated`表示成功
    2. git clone 远程仓库
       `git clone git@github.com:yourusername/yourrepo.git`
4.  运行 docker 脚本
    1.  从终端 cd 到仓库目录
    2.  构建镜像并运行 `sudo docker-compose up -d`
5.  访问 URL 地址
    1.  打开浏览器
    2.  输入正确的 URL `https://yourdomain.com/path/`
    3.  应该可以看到你的网页了

## 可能遇到的问题

1.  端口冲突  
    报错：failed to bind host port for 0.0.0.0:80:172.18.0.2:80/tcp: address already in use
    1.  查看端口占用情况 `sudo lsof -i :80`
    2.  如果看到类似这样的输出：
        ```
        nginx    1234    root    6u  IPv4  12345      0t0  TCP *:80 (LISTEN)
        ```
    3.  关闭端口 `sudo systemctl stop nginx`
    4.  重新运行 docker 脚本
2.  配置镜像加速错误
    1.  检查配置文件是否正确 `sudo cat /etc/docker/daemon.json`
        应该显示类似：
        ```
        {
            "registry-mirrors": [
            "https://mirror.ccs.tencentyun.com"
          ]
        }
        ```
    2.  如果配置不正确，需要创建或者修改配置文件
        1. 删除配置文件 `sudo rm /etc/docker/daemon.json`
        2. 创建新的配置文件 `sudo nano /etc/docker/daemon.json`
        3. 输入配置内容
           ```
           {
               "registry-mirrors": [
               "https://mirror.ccs.tencentyun.com"
             ]
           }
           ```
        4. 保存并退出 `:wq`
        5. 检查配置文件是否正确 `sudo docker info | grep -A 5 Mirrors`
           应该显示类似：
           ```
           Registry Mirrors:
           https://mirror.ccs.tencentyun.com/
           Live Restore Enabled: false
           ```
        6. 重新加载配置 `sudo systemctl daemon-reload`
        7. 重启 docker `sudo systemctl restart docker`
    3.  重新运行 docker 脚本
