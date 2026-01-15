# Cursor Commands 使用说明

## Hugo 博客管理命令

本项目包含一个综合的 Hugo 博客管理命令，支持创建文档、预览网站和部署到 GitHub。

## 快速开始

### 1. 创建新文档

```bash
# 创建文档（在 content/docs/ 目录下）
.cursor/commands/hugo-blog.sh create docs my-topic details my-doc

# 创建文章（在 content/posts/ 目录下）
.cursor/commands/hugo-blog.sh create posts my-article

# 创建页面（在 content/homepage/ 目录下）
.cursor/commands/hugo-blog.sh create pages my-page
```

### 2. 预览网站

```bash
# 启动开发服务器（默认端口 1313）
.cursor/commands/hugo-blog.sh preview

# 启动开发服务器（包含草稿）
.cursor/commands/hugo-blog.sh preview --drafts

# 启动开发服务器（指定端口）
.cursor/commands/hugo-blog.sh preview --port 8080
```

### 3. 部署到 GitHub

```bash
# 使用 Angular 规范的提交信息
.cursor/commands/hugo-blog.sh deploy "feat: 添加新文档"

# 或者交互式输入提交信息
.cursor/commands/hugo-blog.sh deploy
```

## 命令别名（可选）

为了方便使用，可以在 `~/.bashrc` 或 `~/.zshrc` 中添加别名：

```bash
alias hugo-blog='.cursor/commands/hugo-blog.sh'
```

然后就可以直接使用：

```bash
hugo-blog create docs my-topic details my-doc
hugo-blog preview
hugo-blog deploy "feat: 添加新文档"
```

## 完整工作流程示例

```bash
# 1. 创建新文档
.cursor/commands/hugo-blog.sh create docs java details java-day-3

# 2. 编辑文档内容
# 使用你喜欢的编辑器编辑 content/docs/java/details/java-day-3.md

# 3. 预览文档
.cursor/commands/hugo-blog.sh preview

# 4. 确认无误后部署
.cursor/commands/hugo-blog.sh deploy "feat: 添加 Java 学习笔记 Day 3"
```

## 注意事项

1. 确保已安装 Hugo（推荐版本 v0.110.0 或更高）
2. 提交信息应遵循 Angular 提交规范（feat, fix, docs, style, refactor, test, chore）
3. 部署后需要等待几分钟让 GitHub Pages 更新
4. 草稿文档（draft: true）不会在构建时发布

## 帮助信息

查看完整帮助信息：

```bash
.cursor/commands/hugo-blog.sh help
```
