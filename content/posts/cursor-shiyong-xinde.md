---
title: "cursor使用心得"
description: "记录使用 Cursor IDE 的体验和心得"
toc: true
enableComment: true
authors:
  - onceking
tags: ['cursor', 'ide', '开发工具']
categories: ['工具']
series:
date: 2025-01-15T16:10:00+08:00
lastmod: 2025-01-15T16:10:00+08:00
draft: false
---

## 简介

Cursor 是一款基于 AI 的代码编辑器，由 VSCode 分支而来，集成了强大的 AI 辅助编程功能。本文记录 Cursor IDE 的下载安装、使用方式和基本配置，作为入门参考。

## 下载安装

### 官方下载

1. 访问 [Cursor 官网](https://cursor.com)
2. 根据操作系统选择对应版本下载：
   - **Windows**: 下载 `.exe` 安装包
   - **macOS**: 下载 `.dmg` 安装包
   - **Linux**: 下载 `.AppImage` 或 `.deb` 安装包

### 安装步骤

- **Windows/macOS**: 运行安装包，按照向导完成安装
- **Linux**:

  ```bash
  # .deb 包安装
  sudo dpkg -i cursor_*.deb
  
  # 或使用 AppImage（直接运行）
  chmod +x cursor-*.AppImage
  ./cursor-*.AppImage
  ```

安装完成后，首次启动需要登录或注册账号。

## 使用方式

### Agent 模式

Agent 模式是 Cursor 的核心功能，AI 助手可以：

- 自动分析代码上下文
- 提供智能代码补全
- 回答代码相关问题
- 协助重构和优化代码

**使用方式：**

- 使用快捷键 `Ctrl+K` (Windows/Linux) 或 `Cmd+K` (macOS) 打开 AI 对话
- 在聊天框中输入问题或需求
- AI 会根据当前代码上下文提供建议

### Plan 模式

Plan 模式用于处理复杂的多文件任务：

- 分析整个项目结构
- 制定实施计划
- 分步骤执行代码修改

**使用方式：**

- 使用快捷键 `Ctrl+L` (Windows/Linux) 或 `Cmd+L` (macOS)
- 描述需要完成的任务
- AI 会生成执行计划并逐步实施

### Chat 模式

Chat 模式提供对话式编程辅助：

- 与 AI 进行自然语言对话
- 获取代码解释和建议
- 学习编程知识

**使用方式：**

- 点击侧边栏的聊天图标
- 或使用快捷键打开聊天面板

## 配置

### Cursor Rules (.cursorrules)

`.cursorrules` 文件用于定义项目的编码规范和 AI 行为规则：

**创建位置：** 项目根目录

**示例配置：**

```markdown
# Cursor Rules for Hugo Static Site Project

## Project Overview
This is a Hugo static site project using the Eureka theme.

## Code Style Guidelines
- Use consistent Markdown formatting
- Follow existing content structure patterns
- Use Chinese language for content
```

### Commands (.cursor/commands)

Commands 允许创建自定义命令来简化工作流程：

**创建位置：** `.cursor/commands/` 目录

**示例：** 创建 `hugo-blog.sh` 脚本用于管理 Hugo 博客：

- 创建新文档
- 预览网站
- 部署到 GitHub

### 其他配置

- **Settings**: 通过 `Ctrl+,` 打开设置，配置 AI 模型、主题等
- **Extensions**: 支持 VSCode 扩展，扩展 Cursor 功能
- **Keybindings**: 自定义快捷键，提高工作效率

## 使用技巧

1. **上下文理解**: Cursor 会分析当前打开的文件，提供更准确的建议
2. **多文件编辑**: 在 Plan 模式下，可以同时修改多个相关文件
3. **代码审查**: 使用 Chat 模式让 AI 审查代码，发现潜在问题
4. **学习工具**: 通过对话学习新技术和最佳实践

## 总结

Cursor 作为 AI 驱动的代码编辑器，大大提升了开发效率。通过合理使用 Agent、Plan 和 Chat 模式，配合项目规则和自定义命令，可以打造个性化的 AI 编程环境。

## 参考链接

- **Cursor 官方文档**: [https://cursor.com/cn/docs](https://cursor.com/cn/docs)
- **Cursor 官网**: [https://cursor.com](https://cursor.com)
