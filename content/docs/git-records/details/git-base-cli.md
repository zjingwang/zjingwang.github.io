---
title: git常用命令
description: 记录一下平时工作用到的git常用命令
toc: true
authors: onceking
tags: ['git']
categories: ['git']
series:
date: 2023-07-25
lastmod: 2023-07-25
draft: false
featuredImage: "/images/lufei.png"
layout: archive
---

git常用命令

<!--more-->
## git记住token，从而避免每次push都要验证

```shell
git config credential.helper store
```

## .gitignore不生效

```shell
git rm -r --cached .
git add .
```

## 基本命令
- ```shell
  git pull --rebase
  ```
  拉取远端代码，并变基到head

- ```shell
  git reset commitId --soft(hard)
  ```
  拉取远端代码，并变基到head

## git维护远端仓库

```shell
git remote add https://github.com/zjingwang/about-me.git
git add .
git commit -m ""
git push -u origin main
```
