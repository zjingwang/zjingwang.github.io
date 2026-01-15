# Hugo 博客管理命令

这是一个用于管理 Hugo 博客项目的综合命令，支持创建文档、预览网站和部署到 GitHub。

## 功能说明

### 1. 补充文档 (Create Document)

创建新的文档文件，支持以下类型：

- **文档 (docs)**: 在 `content/docs/` 目录下创建
- **文章 (posts)**: 在 `content/posts/` 目录下创建
- **页面 (pages)**: 在 `content/homepage/` 目录下创建

### 2. 预览文档 (Preview)

启动 Hugo 本地开发服务器，支持实时预览和热重载。

### 3. 推送文档 (Deploy)

将更改提交并推送到 GitHub，触发自动部署。

## 使用方法

### 创建新文档

```bash
# 创建文档
hugo new docs/topic-name/details/doc-name.md

# 创建文章
hugo new posts/article-name.md

# 创建页面
hugo new homepage/page-name.md
```

### 预览网站

```bash
# 启动开发服务器（默认端口 1313）
hugo server

# 启动开发服务器（包含草稿）
hugo server -D

# 启动开发服务器（指定端口）
hugo server -p 8080
```

### 部署到 GitHub

```bash
# 添加所有更改
git add .

# 提交更改（使用 Angular 规范）
git commit -m "feat: 添加新文档/更新内容"

# 推送到 main 分支
git push origin main
```

## 文档 Frontmatter 模板

创建新文档时，会自动生成以下 frontmatter 模板：

```yaml
---
title: "文档标题"
date: 2024-01-01T10:00:00+08:00
lastmod: 2024-01-01T10:00:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
author: "onceking"
summary: "文档摘要"
---
```

## 注意事项

1. **文档路径**: 文档应放在 `content/docs/` 目录下，建议使用分类目录结构
2. **草稿模式**: 设置 `draft: true` 的文章不会在构建时发布
3. **自动部署**: 推送到 main 分支后，GitHub Actions 会自动构建和部署
4. **部署延迟**: GitHub Pages 更新可能需要几分钟时间
5. **不要提交 public/**: `public/` 目录包含构建产物，已在 `.gitignore` 中排除

## 常用命令组合

```bash
# 创建文档 -> 预览 -> 部署
hugo new docs/my-topic/details/my-doc.md
hugo server
git add . && git commit -m "feat: 添加新文档" && git push origin main
```
