---
title: css选择器
description: 简单复习一下css选择器
toc: true
enableComment: true
authors:
  - onceking 
tags: ['css']
categories: ['css']
series:
date: 2023-08-08T19:26:00+08:00
lastmod: 2023-08-08T19:26:00+08:00 
featuredImage: "/images/lufei.png"
draft: false
---

### 简单复习一下css选择器
- 类选择器  .class，等价于[class~=]
- ID选择器  #id
- 类型选择器   p，div
- 属性选择器  [attr*=]

### 组合
1. 兄弟组合：+ 
   - 同一个父类，而且要相邻（至少有一个兄弟）
2. 子类组合：>
   - 只匹配直系
3. 后代组合：whitespace
   - 如果第二个选择器匹配的元素具有与第一个选择器匹配的祖先（父母，父母的父母，父母的父母的父母等）元素，则它们将被选择。
4. 通用兄弟组合：~
   - 同一个父类，无需相邻
5. 选择器列表：,
   - 类的组合，缺点是，如果有一个类不存在，那么整条都会失效；所以一般用可容错选择器，例如:is(a, b)，这样的好处是即使有无效的类，也不影响整条语句
   

