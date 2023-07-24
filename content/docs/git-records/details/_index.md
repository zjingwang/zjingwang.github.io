---
title: git的一些记录
description: 记录git遇到的问题
toc: true
authors:
    - onceking
tags: ['git']
categories: ['git']
series:
date: '2023-07-24'
lastmod: 
    - :fileModTime
    - :default
draft: false
---

记录一些遇到的git问题

<!--more-->

## git记住token，从而避免每次push都要验证

```
git config credential.helper store
```

## .gitignore不生效

```
git rm -r --cached .
git add .
```
