---
title: hugo自定义一些页面
description: 主要是关于hugo自定义layouts的记录
toc: true
enableComment: true
authors:
  - onceking 
tags: ['hugo']
categories: ['hugo']
series:
date: 2023-07-26T16:32:00+08:00
lastmod: 2023-07-26T16:32:00+08:00
featuredImage:
draft: false
---

参考了<a href="https://imnerd.org/custom-hugo-theme-eureka.html" style="color: green; text-decoration: none;">Hugo 主题 Eureka 自定义</a>这篇文章，总结如下：

- 样式不要在custom-head.html里改，不会生效，要在对应的html里面改，比如index.html:
    ```html
        <style>
        .widget + .widget {
            margin-top: 1rem;
        }
        .widget-title {
            font-weight: bold;
            margin-bottom: 1rem;
        }
        .widget-list li {
            font-size: 0.9rem;
        }
        .bg-cover img {
            opacity: 1;
            transition: all .5s ease-in-out;
            max-width: 100%;
            height: auto;
        }
        .bg-cover img.dark {
            opacity: 0;
            height: 0;
        }
        .dark .bg-cover img.day {
            opacity: 0;
            height: 0;
        }
        .dark .bg-cover img.dark {
            opacity: 1;
            height: auto;
        }
    </style>
    ```
- search.html需要修改fuseOption，否则不支持中文查询，如下
    ```html
        const fuseOptions = {
            shouldSort: true,
            includeMatches: true,
            //  threshold: 0.0,
            threshold: 0.3,
            tokenize:true,
            location: 0,
            distance: 100,
            maxPatternLength: 32,
            minMatchCharLength: 1,
            keys: [
            {name:"title",weight:0.8},
            {name:"contents",weight:0.5},
            {name:"tags",weight:0.3}
            //    , {name:"categories",weight:0.3}
            ]
        };
    ```
  
- stats.html少了一些类，导致echarts报错，修改如下：
    ```html
        <div id="year-stat" class="my-4" style="width: 100%;height:400px;">
        </div>
        <div id="month-stat" class="my-4" style="width: 100%;height:400px;">
        </div>
        <div id="hour-stat" class="my-4" style="width: 100%;height:400px;">
        </div>
        <div id="weekday-stat" class="my-4" style="width: 100%;height:400px;">
        </div>
    ```