# 生信助力科技有限公司网站

## 项目结构

### 布局文件 (layouts/)
```
layouts/
├── index.html                    # 主页面布局（仅组装各区块 partial）
├── _default/
│   └── baseof.html              # 页面骨架（head/meta/SEO/结构化数据）
├── partials/
│   ├── header.html              # 导航栏组件
│   ├── footer.html              # 页脚组件
│   ├── sections/                # 页面区块组件
│   │   ├── hero.html           # 英雄区域
│   │   ├── about.html          # 关于我们
│   │   ├── services.html       # 核心服务（数据驱动）
│   │   └── contact.html        # 联系我们（数据驱动）
│   └── components/              # 可复用组件
│       ├── service-card.html    # 服务卡片组件
│       └── contact-item.html    # 联系信息组件
```

### 数据文件 (data/)
```
data/
├── services.yaml                # 服务信息数据（页面服务区块唯一内容来源）
└── contact.yaml                 # 联系信息数据（页面联系区块唯一内容来源）
```

### 前端资源 (src/)
```
src/
├── main.js                      # 入口：Bootstrap JS、Font Awesome（自托管）
└── styles.scss                  # 样式（Bootstrap SCSS + 自定义主题变量）
```

## 设计说明

### 1. 模块化设计
- 页面内容按逻辑关系拆分为 partial 文件，主布局只负责组装
- 服务、联系信息由 YAML 数据文件驱动，页面模板只负责渲染

### 2. 单一内容来源
- 服务卡片内容：只改 `data/services.yaml`
- 联系信息：只改 `data/contact.yaml`
- 站点级信息（title/description/email/address/keywords）：只改 `hugo.toml`
- 页面区块的静态文案：改对应的 `layouts/partials/sections/*.html`

### 3. 前端构建
- 前端资源由 Vite 构建到 `static/assets/`（已 gitignore，勿直接编辑）
- 依赖本地化：Bootstrap、Font Awesome 均从 npm 打包，无外部 CDN 依赖
- 中文字体使用系统字体栈（PingFang SC / Microsoft YaHei 等），不加载外部字体

## 使用说明

### 本地开发
```bash
npm install
npm run dev        # 构建资源并启动 Hugo 开发服务器
```

### 生产构建
```bash
npm run build      # Vite 构建资源 + Hugo 构建站点到 public/
```

### 添加新服务
1. 在 `data/services.yaml` 中添加服务信息
2. 服务会自动显示在页面上

### 修改联系信息
1. 在 `data/contact.yaml` 中修改联系信息
2. 联系信息会自动更新

### 添加新页面区块
1. 在 `layouts/partials/sections/` 中创建新的 section 文件
2. 在主布局文件中引用新的 section

## 样式规范

### 颜色变量
- 使用 CSS 变量定义颜色主题
- 遵循 Bootstrap 的配色方案
- 自定义变量以 `--bioinfo-` 前缀命名

### 响应式设计
- 使用 Bootstrap 的栅格系统
- 遵循移动优先的设计原则
- 使用 Bootstrap 的断点进行适配

### 组件样式
- 使用语义化的类名
- 保持样式的一致性
- 优先使用 Bootstrap 类名，必要时才自定义
