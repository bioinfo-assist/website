# 北京生信助力科技有限公司

专注于生物信息学数据分析、临床数据挖掘和软件开发。

## 快速开始

### 构建网站

```bash
# 使用构建脚本
./build.sh

# 或者直接使用Hugo命令
hugo --minify
```

构建完成后，网站文件将生成在 `public/` 目录中。

### 开发模式

```bash
# 启动开发服务器
hugo server --bind 0.0.0.0 --port 1313
```

访问 http://localhost:1313 查看网站。

## 项目结构

```
.
├── layouts/          # Hugo模板文件
│   ├── _default/     # 默认模板
│   ├── partials/     # 部分模板
│   └── index.html    # 主页模板
├── static/           # 静态资源
│   ├── css/          # 样式文件
│   ├── js/           # JavaScript文件
│   └── images/       # 图片文件
├── content/          # 内容文件
├── hugo.toml         # Hugo配置文件
└── build.sh          # 构建脚本
```

## 技术栈

- Hugo - 静态网站生成器
- Bootstrap - CSS框架
- 响应式设计
