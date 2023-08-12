---
title: 记录一下本地git repo迁移到Windows
description: windows使用hugo部署文档
toc: true
authors: onceking
tags: ['hugo']
categories: ['hugo']
series:
date: '2023-07-29T15:10:00+08:00'
lastmod: '2023-07-29T5:10:00+08:00'
draft: false
featuredImage: "/images/lufei.png"
---

把本git仓库从Linux换到了windows，记录下

## 安装hugo
```shell
winget install Hugo.Hugo.Extended
```

下载成功了，但是环境配置没生效，所以改成手动下载了
1. 下载地址[hugo](https://objects.githubusercontent.com/github-production-release-asset-2e65be/11180687/6bbca91a-9517-4005-b6ab-dc6ae39d4cea?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230729%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230729T062742Z&X-Amz-Expires=300&X-Amz-Signature=e305ac70288f64b7741eb33605337a2134edacd8444e4e4ef1583c7eda64b899&X-Amz-SignedHeaders=host&actor_id=46661079&key_id=0&repo_id=11180687&response-content-disposition=attachment%3B%20filename%3Dhugo_extended_0.115.4_windows-amd64.zip&response-content-type=application%2Foctet-stream)
2. 配置环境变量
    ```text
    1. 打开"控制面板"：您可以通过在Windows操作系统中点击"开始"按钮，然后输入"控制面板"来打开控制面板。
    2. 选择"系统和安全"：在控制面板中，选择"系统和安全"选项。
    3. 点击"系统"：在"系统和安全"页面中，点击"系统"选项。
    4. 点击"高级系统设置"：在"系统"页面上方，您会看到一些系统相关的信息。在这个页面中，点击"高级系统设置"链接。
    5. 打开"环境变量"：在"系统属性"对话框中，点击"环境变量"按钮。
    6. 查看和编辑"Path"变量：在"环境变量"对话框中，您会看到两个框，分别是"用户变量"和"系统变量"。在"系统变量"框中找到名为"Path"的变量，并点击"编辑"按钮。
    7. 检查Hugo程序的路径：在"编辑环境变量"对话框中，您会看到"Path"变量的值。请确保该值包含Hugo程序的安装路径。如果Hugo程序的路径尚未添加到"Path"变量中，您可以点击"新建"按钮并添加Hugo程序的路径。
    8. 保存更改：完成路径的编辑后，依次点击"确定"按钮关闭所有打开的对话框，并保存更改。
    ```

## 安装commitizen
```shell
npm install -g commitizen
```
初始化
```shell
commitizen init cz-conventional-changelog --save --save-exact
```
使用
```shell
git cz
```

