---
title: 修改 Git 历史提交的提交人信息
description: 如何批量修改 Git 历史提交中的提交人名称和邮箱地址
toc: true
authors: onceking
tags: ['git', 'rewrite', 'history']
categories: ['git']
series:
date: 2026-02-10
lastmod: 2026-02-10
draft: false
featuredImage: "/images/lufei.png"
layout: archive
---

修改 Git 历史提交的提交人信息（名称和邮箱）

<!--more-->

## 概述

有时候我们需要批量修改 Git 历史提交中的提交人信息，比如：
- 统一提交人名称（例如：将 `王XX` 改为 `zjingwang`）
- 统一邮箱地址（例如：将 `1234@qq.com` 改为 `jing2290426141@163.com`）

**⚠️ 警告**：修改 Git 历史是一个危险操作，会重写所有提交的哈希值。如果已经推送到远程仓库，需要强制推送，这会影响所有协作者。

## 准备工作

### 1. 查看当前提交历史

首先查看提交历史，了解需要修改的提交人信息：

```bash
# 查看最近 20 条提交的提交人信息
git log --pretty=format:"%h - %an <%ae> : %s" -20

# 统计所有提交人名称
git log --pretty=format:"%an" | sort | uniq -c | sort -rn

# 统计所有邮箱地址
git log --pretty=format:"%ae" | sort | uniq -c | sort -rn
```

### 2. 创建备份分支

在修改历史之前，强烈建议创建一个备份分支：

```bash
git branch backup-before-rewrite
```

## 修改提交人名称

使用 `git filter-branch` 批量修改提交人名称：

```bash
git filter-branch -f --env-filter '
if [[ "$GIT_AUTHOR_NAME" == *"王XX"* ]]; then
    export GIT_AUTHOR_NAME="zjingwang"
fi
if [[ "$GIT_COMMITTER_NAME" == *"王XX"* ]]; then
    export GIT_COMMITTER_NAME="zjingwang"
fi
' --tag-name-filter cat -- --branches --tags
```

**说明**：
- `--env-filter`：设置环境变量来修改提交信息
- `GIT_AUTHOR_NAME`：提交作者名称
- `GIT_COMMITTER_NAME`：提交者名称
- `*"王XX"*`：匹配包含 "王XX" 的提交人名称
- `--tag-name-filter cat`：保持标签名称不变
- `-- --branches --tags`：对所有分支和标签执行操作

## 修改邮箱地址

使用 `git filter-branch` 批量修改邮箱地址：

```bash
git filter-branch -f --env-filter '
if [ "$GIT_AUTHOR_EMAIL" = "1234@qq.com" ]; then
    export GIT_AUTHOR_EMAIL="jing2290426141@163.com"
fi
if [ "$GIT_COMMITTER_EMAIL" = "1234@qq.com" ]; then
    export GIT_COMMITTER_EMAIL="jing2290426141@163.com"
fi
' --tag-name-filter cat -- --branches --tags
```

**说明**：
- `GIT_AUTHOR_EMAIL`：提交作者邮箱
- `GIT_COMMITTER_EMAIL`：提交者邮箱
- 精确匹配邮箱地址进行替换

## 同时修改名称和邮箱

如果需要同时修改名称和邮箱，可以在一个命令中完成：

```bash
git filter-branch -f --env-filter '
# 修改提交人名称
if [[ "$GIT_AUTHOR_NAME" == *"王XX"* ]]; then
    export GIT_AUTHOR_NAME="zjingwang"
fi
if [[ "$GIT_COMMITTER_NAME" == *"王XX"* ]]; then
    export GIT_COMMITTER_NAME="zjingwang"
fi
# 修改邮箱地址
if [ "$GIT_AUTHOR_EMAIL" = "1234@qq.com" ]; then
    export GIT_AUTHOR_EMAIL="jing2290426141@163.com"
fi
if [ "$GIT_COMMITTER_EMAIL" = "1234@qq.com" ]; then
    export GIT_COMMITTER_EMAIL="jing2290426141@163.com"
fi
' --tag-name-filter cat -- --branches --tags
```

## 验证修改结果

修改完成后，验证结果：

```bash
# 查看修改后的提交历史
git log --pretty=format:"%h - %an <%ae> : %s" -20

# 检查是否还有需要修改的提交人
git log --pretty=format:"%an" | grep -i "王XX" | wc -l

# 检查是否还有需要修改的邮箱
git log --pretty=format:"%ae" | grep -i "1234@qq.com" | wc -l
```

## 清理旧的引用

`git filter-branch` 会创建备份引用，清理这些引用以释放空间：

```bash
# 删除 filter-branch 创建的备份引用
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d

# 清理 reflog 和垃圾回收
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

## 推送到远程仓库

由于历史已被重写，需要强制推送到远程仓库：

```bash
git push origin main --force
```

**⚠️ 重要提示**：
- 强制推送会覆盖远程仓库的历史记录
- 如果有其他协作者，需要通知他们：
  - 重新克隆仓库，或
  - 执行 `git fetch origin` 和 `git reset --hard origin/main`（会丢失本地未推送的更改）

## 恢复备份

如果修改出现问题，可以从备份分支恢复：

```bash
# 查看备份分支
git branch | grep backup

# 恢复到备份分支的状态
git reset --hard backup-before-rewrite
```

## 完整操作流程示例

以下是一个完整的操作流程示例：

```bash
# 1. 查看当前提交历史
git log --pretty=format:"%h - %an <%ae>" -20

# 2. 创建备份分支
git branch backup-before-rewrite

# 3. 修改提交人名称
git filter-branch -f --env-filter '
if [[ "$GIT_AUTHOR_NAME" == *"王XX"* ]]; then
    export GIT_AUTHOR_NAME="zjingwang"
fi
if [[ "$GIT_COMMITTER_NAME" == *"王XX"* ]]; then
    export GIT_COMMITTER_NAME="zjingwang"
fi
' --tag-name-filter cat -- --branches --tags

# 4. 修改邮箱地址
git filter-branch -f --env-filter '
if [ "$GIT_AUTHOR_EMAIL" = "1234@qq.com" ]; then
    export GIT_AUTHOR_EMAIL="jing2290426141@163.com"
fi
if [ "$GIT_COMMITTER_EMAIL" = "1234@qq.com" ]; then
    export GIT_COMMITTER_EMAIL="jing2290426141@163.com"
fi
' --tag-name-filter cat -- --branches --tags

# 5. 验证修改结果
git log --pretty=format:"%h - %an <%ae>" -20

# 6. 清理旧的引用
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 7. 强制推送到远程仓库
git push origin main --force
```

## 注意事项

1. **备份重要**：修改历史前一定要创建备份分支
2. **团队协作**：如果有其他协作者，需要提前通知并协调
3. **不可逆操作**：修改历史后，旧的提交哈希值会改变
4. **强制推送风险**：强制推送会覆盖远程历史，需要谨慎操作
5. **GitHub Actions**：如果使用 GitHub Actions，修改历史后会自动触发新的构建

## 替代方案

Git 官方推荐使用 `git filter-repo` 替代 `git filter-branch`，因为它更快速、更安全：

```bash
# 安装 git-filter-repo
pip install git-filter-repo

# 修改提交人信息
git filter-repo --name-callback 'return name.replace(b"王XX", b"zjingwang")' \
                --email-callback 'return email.replace(b"1234@qq.com", b"jing2290426141@163.com")'
```

## 参考链接

- [Git 官方文档 - git-filter-branch](https://git-scm.com/docs/git-filter-branch)
- [Git 官方文档 - git-filter-repo](https://github.com/newren/git-filter-repo)
