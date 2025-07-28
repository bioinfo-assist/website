#!/bin/bash

# 部署脚本
echo "开始部署..."

# 构建网站
./build.sh

if [ $? -eq 0 ]; then
    echo "构建完成，准备部署..."
    
    # 这里可以添加部署到服务器的命令
    # 例如：rsync -avz public/ user@server:/var/www/html/
    
    echo "部署完成！"
    echo "网站文件在 public/ 目录中，可以上传到服务器。"
else
    echo "构建失败，部署中止！"
    exit 1
fi 