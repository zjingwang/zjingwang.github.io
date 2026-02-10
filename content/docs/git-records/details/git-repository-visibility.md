---
title: GitHub 仓库可见性：Public vs Private
description: 了解 Public 和 Private 仓库的区别，以及改为 Private 对 GitHub Pages 的影响
toc: true
authors: onceking
tags: ['git', 'github', 'security', 'pages']
categories: ['git']
series:
date: 2026-02-10
lastmod: 2026-02-10
draft: false
featuredImage: "/images/lufei.png"
layout: archive
---

GitHub 仓库可见性：Public vs Private

<!--more-->

## 概述

GitHub 仓库有两种可见性设置：
- **Public（公开）**：任何人都可以查看仓库代码
- **Private（私有）**：只有授权用户可以查看仓库代码

选择哪种可见性取决于你的需求和 GitHub 账户类型。

## Public 仓库的权限说明

### 默认权限

**重要**：Public 仓库并不意味着任何人都可以随意提交代码！

#### ✅ 其他人可以做什么

1. **查看代码**
   - 可以浏览仓库内容
   - 可以克隆（clone）仓库
   - 可以查看提交历史
   - 可以查看 Issues 和 Pull Requests

2. **Fork 仓库**
   - 可以 Fork 到自己的账户
   - 在自己的 Fork 中修改代码
   - 通过 Pull Request 贡献代码（需要仓库所有者审核）

3. **创建 Issue**
   - 可以报告问题
   - 可以提出功能建议
   - （取决于仓库设置）

#### ❌ 其他人不能做什么

1. **直接推送代码**
   - 不能直接 `git push` 到你的仓库
   - 不能修改主分支（main/master）
   - 不能删除仓库或修改设置

2. **修改仓库设置**
   - 不能更改仓库可见性
   - 不能添加/删除协作者
   - 不能修改 GitHub Actions 工作流

### 如何控制权限

#### 1. 协作者（Collaborators）

只有被明确添加为**协作者**的人才能直接推送代码：

```bash
# 在 GitHub 网页上添加协作者
# Settings → Collaborators → Add people
```

**权限级别**：
- **Read（只读）**：只能查看和克隆
- **Triage（分类）**：可以管理 Issues 和 PR
- **Write（写入）**：可以推送代码到非保护分支
- **Maintain（维护）**：可以管理仓库设置
- **Admin（管理员）**：完全控制权限

#### 2. 分支保护规则

可以设置分支保护规则，防止直接推送到主分支：

```yaml
# 在 GitHub 仓库设置中：
# Settings → Branches → Add rule

保护规则：
- Require pull request reviews before merging
- Require status checks to pass before merging
- Require conversation resolution before merging
```

#### 3. 禁用某些功能

在仓库设置中可以禁用：
- Issues
- Wiki
- Projects
- Discussions

## Private 仓库的影响

### ⚠️ 重要限制：GitHub Pages

**免费账户的限制**：
- ❌ **Private 仓库不能使用免费的 GitHub Pages**
- ✅ 只有 **GitHub Pro/Team/Enterprise** 账户才能为 Private 仓库启用 GitHub Pages

### 改为 Private 的影响

#### 1. GitHub Pages 无法使用（免费账户）

如果改为 Private，你的网站 `https://zjingwang.github.io/` 将**无法继续运行**，因为：

```yaml
当前配置：
- 仓库：zjingwang.github.io (Public)
- GitHub Pages：自动部署
- 访问地址：https://zjingwang.github.io/

改为 Private 后（免费账户）：
- ❌ GitHub Pages 功能被禁用
- ❌ 网站无法访问
- ❌ GitHub Actions 部署工作流可能失败
```

#### 2. 代码访问限制

**优点**：
- ✅ 代码完全私有，只有授权用户可以查看
- ✅ 保护敏感信息（API 密钥、配置等）
- ✅ 控制谁可以访问仓库

**缺点**：
- ❌ 其他人无法查看和学习你的代码
- ❌ 无法通过 Public 仓库展示项目
- ❌ 搜索引擎无法索引代码

#### 3. GitHub Actions

**影响**：
- ✅ GitHub Actions 在 Private 仓库中仍然可用
- ⚠️ 但 GitHub Pages 部署功能需要付费账户

#### 4. 协作影响

**变化**：
- ✅ 仍然可以添加协作者
- ✅ 仍然可以使用 Pull Requests
- ❌ 但需要明确授权才能访问

## 解决方案和建议

### 方案一：保持 Public + 加强安全

如果希望继续使用免费的 GitHub Pages，建议保持 Public，但加强安全措施：

#### 1. 检查敏感信息

```bash
# 检查是否有敏感信息泄露
# 使用工具扫描：
- git-secrets
- truffleHog
- gitleaks

# 检查历史提交
git log --all --full-history --source -- "*password*" "*secret*" "*key*"
```

#### 2. 使用环境变量

不要在代码中硬编码敏感信息：

```yaml
# ❌ 错误做法
api_key: "sk-1234567890abcdef"

# ✅ 正确做法
api_key: ${GITHUB_API_KEY}  # 使用环境变量
```

#### 3. 使用 .gitignore

确保敏感文件不被提交：

```gitignore
# .gitignore
.env
*.key
*.pem
secrets/
config/local.yaml
```

#### 4. 设置分支保护

```yaml
# Settings → Branches → Add rule
分支保护规则：
- 保护 main 分支
- 要求 PR 审核
- 要求状态检查通过
```

#### 5. 定期审查协作者

```bash
# 定期检查协作者列表
# Settings → Collaborators
# 移除不再需要的协作者
```

### 方案二：升级到 GitHub Pro

如果需要 Private 仓库 + GitHub Pages：

**GitHub Pro 费用**：
- 个人：$4/月
- 功能：Private 仓库 + GitHub Pages + 更多 Actions 分钟数

**升级步骤**：
1. 访问 GitHub Settings → Billing
2. 选择 GitHub Pro 计划
3. 升级后，Private 仓库可以使用 GitHub Pages

### 方案三：使用其他托管方案

如果改为 Private，可以考虑其他静态网站托管：

#### 1. Netlify

```yaml
优点：
- 支持 Private 仓库
- 免费计划可用
- 自动部署
- 自定义域名

配置：
- 连接 GitHub 仓库
- 设置构建命令：hugo --gc --minify
- 设置发布目录：public
```

#### 2. Vercel

```yaml
优点：
- 支持 Private 仓库
- 免费计划可用
- 快速部署
- 全球 CDN

配置：
- 连接 GitHub 仓库
- 自动检测 Hugo
- 零配置部署
```

#### 3. Cloudflare Pages

```yaml
优点：
- 支持 Private 仓库
- 免费计划可用
- 无限带宽
- 全球 CDN

配置：
- 连接 GitHub 仓库
- 设置构建命令和输出目录
```

## 当前仓库建议

### 推荐：保持 Public

**理由**：
1. ✅ **免费使用 GitHub Pages**：当前网站正常运行
2. ✅ **代码展示**：可以展示项目和技术能力
3. ✅ **学习交流**：其他人可以学习和参考
4. ✅ **SEO 友好**：搜索引擎可以索引代码

### 安全措施

1. **检查敏感信息**
   ```bash
   # 扫描仓库中的敏感信息
   git log --all --full-history --source -- "*password*" "*token*" "*secret*"
   ```

2. **使用 .gitignore**
   - 确保不提交敏感文件
   - 定期检查 `.gitignore` 配置

3. **分支保护**
   - 保护 main 分支
   - 要求 PR 审核

4. **定期审查**
   - 检查协作者列表
   - 审查 Issues 和 PR

## 总结

### Public 仓库

| 功能 | 权限 |
|------|------|
| 查看代码 | ✅ 所有人 |
| 克隆仓库 | ✅ 所有人 |
| 推送代码 | ❌ 仅协作者 |
| GitHub Pages | ✅ 免费 |
| 创建 PR | ✅ 所有人（需审核） |

### Private 仓库（免费账户）

| 功能 | 权限 |
|------|------|
| 查看代码 | ❌ 仅协作者 |
| 克隆仓库 | ❌ 仅协作者 |
| 推送代码 | ❌ 仅协作者 |
| GitHub Pages | ❌ 需要付费账户 |
| 创建 PR | ❌ 仅协作者 |

### 建议

1. **保持 Public**：如果使用免费的 GitHub Pages
2. **加强安全**：使用分支保护、环境变量、.gitignore
3. **定期审查**：检查协作者和敏感信息
4. **考虑升级**：如果需要 Private + Pages，升级到 GitHub Pro

## 参考链接

- [GitHub 仓库可见性文档](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [GitHub 分支保护文档](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)
- [GitHub Pro 计划](https://github.com/pricing)
