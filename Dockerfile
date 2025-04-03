FROM caddy:latest

# 设置工作目录
WORKDIR /h5

# 复制本地的 h5 文件夹到容器中
COPY h5/ /h5/

# 复制 Caddyfile 到容器中
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露端口
EXPOSE 3000

# 启动 Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
