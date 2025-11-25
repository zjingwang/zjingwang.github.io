# onceking 个人博客

基于 [Hugo](https://gohugo.io/) 静态网站生成器和 [Eureka](https://www.wangchucheng.com/zh/docs/eureka/) 主题构建的个人博客网站。

## 📋 目录

- [项目简介](#项目简介)
- [环境要求](#环境要求)
- [本地开发](#本地开发)
- [添加内容](#添加内容)
- [构建和部署](#构建和部署)
- [项目结构](#项目结构)

## 📖 项目简介

这是一个使用 Hugo 构建的静态网站项目，部署在 GitHub Pages 上。网站地址：https://zjingwang.github.io/

## 🔧 环境要求

- [Hugo](https://gohugo.io/installation/) (推荐版本 v0.110.0 或更高)
- [Git](https://git-scm.com/)
- [Go](https://go.dev/) (用于 Hugo Modules)

### 安装 Hugo

**Windows:**
```powershell
# 使用 Chocolatey
choco install hugo-extended

# 或使用 Scoop
scoop install hugo-extended
```

**macOS:**
```bash
brew install hugo
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install hugo

# 或从 GitHub 下载
wget https://github.com/gohugoio/hugo/releases/download/v0.110.0/hugo_extended_0.110.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.110.0_linux-amd64.deb
```

## 🚀 本地开发

### 1. 克隆项目

```bash
git clone https://github.com/zjingwang/zjingwang.github.io.git
cd zjingwang.github.io
```

### 2. 安装依赖

```bash
# 安装 Hugo Modules (主题)
hugo mod download

# 安装 Node.js 依赖（如果有）
npm install
```

### 3. 启动本地服务器

```bash
hugo server
```

访问 http://localhost:1313 查看网站。

### 4. 实时预览

Hugo 支持热重载，修改内容后浏览器会自动刷新。

## ✍️ 添加内容

### 添加新文章

在 `content/posts/` 目录下创建新的 Markdown 文件：

```bash
hugo new posts/my-new-post.md
```

或手动创建文件，内容格式如下：

```markdown
---
title: "文章标题"
date: 2024-01-01T10:00:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
---

文章内容...
```

### 添加文档

在 `content/docs/` 目录下创建新的文档：

```bash
# 创建文档目录
mkdir -p content/docs/my-topic/details

# 创建文档文件
hugo new docs/my-topic/details/my-doc.md
```

文档结构示例：
```
content/docs/
  └── my-topic/
      ├── _index.md      # 目录索引页
      └── details/
          └── my-doc.md  # 具体文档
```

### 添加页面

在 `content/homepage/` 目录下创建新页面：

```bash
hugo new homepage/my-page.md
```

### 内容文件 Frontmatter 说明

```yaml
---
title: "标题"                    # 必需
date: 2024-01-01T10:00:00+08:00  # 发布日期
lastmod: 2024-01-02T10:00:00+08:00  # 最后修改日期
draft: false                      # 是否为草稿（true 时不会发布）
tags: ["标签1", "标签2"]          # 标签
categories: ["分类"]              # 分类
author: "onceking"                # 作者
summary: "文章摘要"               # 摘要
---
```

## 🏗️ 构建和部署

### 本地构建

```bash
# 构建生产版本（包含压缩和优化）
hugo --gc --minify

# 构建后的文件在 public/ 目录
```

### 部署到 GitHub Pages

项目已配置 GitHub Actions 自动部署，有两种方式：

#### 方式一：自动部署（推荐）

1. **提交代码到 GitHub**

```bash
# 添加修改的文件
git add .

# 提交更改
git commit -m "feat: 添加新文章/更新内容"

# 推送到 GitHub
git push origin main
```

2. **自动部署**

推送代码到 `main` 分支后，GitHub Actions 会自动：
- 安装 Hugo
- 构建网站
- 部署到 GitHub Pages

3. **查看部署状态**

- 访问 GitHub 仓库的 **Actions** 标签页查看部署进度
- 部署完成后，访问 https://zjingwang.github.io/ 查看更新

#### 方式二：手动触发部署

1. 访问 GitHub 仓库
2. 点击 **Actions** 标签页
3. 选择 **Deploy Hugo site to Pages** 工作流
4. 点击 **Run workflow** 按钮手动触发

### 部署流程说明

GitHub Actions 工作流 (`.github/workflows/hugo.yaml`) 执行以下步骤：

1. **构建阶段**：
   - 安装 Hugo CLI
   - 安装 Dart Sass
   - 检出代码（包括子模块）
   - 安装 Node.js 依赖
   - 使用 `hugo --gc --minify` 构建网站

2. **部署阶段**：
   - 将构建产物上传到 GitHub Pages
   - 自动更新网站内容

### 验证部署

部署完成后，等待几分钟让 GitHub Pages 更新，然后访问：
- https://zjingwang.github.io/

## 📁 项目结构

```
zjingwang.github.io/
├── .github/
│   └── workflows/
│       └── hugo.yaml          # GitHub Actions 部署配置
├── assets/                     # 源资源文件
│   └── images/                 # 图片资源
├── config/                     # Hugo 配置文件
│   └── _default/
│       ├── config.yaml         # 主配置文件
│       ├── languages.yaml      # 语言配置
│       ├── menus.yaml          # 菜单配置
│       └── params.yaml         # 参数配置
├── content/                    # 内容文件
│   ├── authors/                # 作者信息
│   ├── docs/                   # 文档
│   ├── homepage/               # 首页页面
│   ├── posts/                  # 博客文章
│   └── ...
├── layouts/                    # 自定义模板
│   ├── _default/               # 默认模板
│   ├── components/             # 组件
│   └── partials/               # 部分模板
├── static/                     # 静态文件（直接复制到输出）
│   ├── images/                 # 静态图片
│   └── js/                     # JavaScript 文件
├── .gitignore                  # Git 忽略文件
├── .cursorrules                # Cursor IDE 规则
├── go.mod                      # Go 模块配置
├── netlify.toml                # Netlify 配置（可选）
├── package.json                # Node.js 依赖
└── README.md                   # 本文件
```

## 🔍 常用命令

```bash
# 启动开发服务器
hugo server

# 启动开发服务器（包含草稿）
hugo server -D

# 构建生产版本
hugo --gc --minify

# 创建新文章
hugo new posts/article-name.md

# 创建新文档
hugo new docs/topic/doc-name.md

# 查看 Hugo 版本
hugo version

# 清理构建缓存
hugo --gc
```

## 📚 参考资源

- [Hugo 官方文档](https://gohugo.io/documentation/)
- [Eureka 主题文档](https://www.wangchucheng.com/zh/docs/eureka/)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Markdown 语法](https://www.markdownguide.org/)

## 📝 注意事项

1. **不要提交 `public/` 目录**：该目录包含构建产物，已在 `.gitignore` 中排除
2. **草稿文章**：设置 `draft: true` 的文章不会在构建时发布
3. **图片路径**：使用相对路径引用图片，如 `images/example.png`
4. **中文内容**：项目默认语言为中文，确保内容文件使用 UTF-8 编码
5. **部署延迟**：GitHub Pages 更新可能需要几分钟时间

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

详见 [LICENSE](LICENSE) 文件。
