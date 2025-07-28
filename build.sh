#!/bin/bash

# 构建Hugo网站
echo "开始构建Hugo网站..."
hugo --minify

# 检查构建结果
if [ $? -eq 0 ]; then
    echo "构建成功！"
    echo "生成的网站文件在 public/ 目录中"
else
    echo "构建失败！"
    exit 1
fi 