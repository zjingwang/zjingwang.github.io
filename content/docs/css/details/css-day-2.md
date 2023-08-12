---
title: css flex布局
description: 简单复习一下css flex布局
toc: true
enableComment: true
authors:
  - onceking 
tags: ['css']
categories: ['css']
series:
date: 2023-08-11T16:33:00+08:00
lastmod: 2023-08-11T16:33:00+08:00
featuredImage: "/images/lufei.png"
draft: false
---

## flex布局
启动flex布局
```css
display: flex;
```
### flex属性
flex分为主轴和交叉轴，主轴就是flex items排列的方向，默认是row，从左到右，交叉轴就是与主轴垂直的方向。
#### flex-direction
控制主轴方向
- row 默认排列方向，从左到右
- row-reverse 从右到左
- column 按列排序，从上到下
- column-reverse 从下到上
#### align-items
控制 flex 项在交叉轴上的位置
- center
- flex-end
- flex-start
- stretch
#### justify-content
控制 flex 项在主轴上的位置
- flex-start，这会使所有 flex 项都位于主轴的开始处。
- flex-end 来让 flex 项到结尾处。
- center 在 justify-content 里也是可用的，可以让 flex 项在主轴居中，和 align-items: center 配合可以使得子项完全居中。
- space-around 使所有 flex 项沿着主轴均匀地分布，在任意一端都会留有一点空间。
- space-between，和 space-around 非常相似，只是它不会在两端留下任何空间。
#### order
控制flex项排序方式，越小排序越前


