# 生信助力科技有限公司网站

## 项目结构

### 布局文件 (layouts/)
```
layouts/
├── index.html                    # 主页面布局
├── partials/
│   ├── header.html              # 导航栏组件
│   ├── footer.html              # 页脚组件
│   ├── sections/                # 页面区块组件
│   │   ├── hero.html           # 英雄区域
│   │   ├── about.html          # 关于我们
│   │   ├── services.html       # 核心服务
│   │   └── contact.html        # 联系我们
│   └── components/              # 可复用组件
│       ├── service-card.html    # 服务卡片组件
│       ├── feature-card.html    # 特色卡片组件
│       └── contact-item.html    # 联系信息组件
```

### 数据文件 (data/)
```
data/
├── services.yaml                # 服务信息数据
└── contact.yaml                 # 联系信息数据
```

### 样式文件 (static/assets/css/)
```
static/assets/css/
├── styles.css                   # Bootstrap样式
└── custom.css                   # 自定义样式
```

## 重构亮点

### 1. 模块化设计
- 将页面内容按逻辑关系拆分为不同的partial文件
- 每个section独立管理，便于维护和复用
- 使用可复用的组件减少代码重复

### 2. 数据驱动
- 使用YAML数据文件管理内容
- 服务信息和联系信息集中管理
- 便于内容更新和维护

### 3. Bootstrap优化
- 充分利用Bootstrap的类名和变量
- 使用语义化的CSS类名
- 减少自定义样式，提高兼容性

### 4. 代码简洁
- 主布局文件从218行减少到12行
- 通过partial文件实现逻辑分离
- 避免重复代码，提高可维护性

## 使用说明

### 添加新服务
1. 在 `data/services.yaml` 中添加服务信息
2. 服务会自动显示在页面上

### 修改联系信息
1. 在 `data/contact.yaml` 中修改联系信息
2. 联系信息会自动更新

### 添加新页面区块
1. 在 `layouts/partials/sections/` 中创建新的section文件
2. 在主布局文件中引用新的section

## 样式规范

### 颜色变量
- 使用CSS变量定义颜色主题
- 遵循Bootstrap的配色方案
- 自定义变量以 `--bioinfo-` 前缀命名

### 响应式设计
- 使用Bootstrap的栅格系统
- 遵循移动优先的设计原则
- 使用Bootstrap的断点进行适配

### 组件样式
- 使用语义化的类名
- 保持样式的一致性
- 优先使用Bootstrap类名，必要时才自定义
