FROM caddy:latest

# 设置工作目录
WORKDIR /web

# 复制本地的 web 文件夹到容器中
COPY web/ /web/

# 复制 Caddyfile 到容器中
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露端口
EXPOSE 3000

# 启动 Caddy
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
