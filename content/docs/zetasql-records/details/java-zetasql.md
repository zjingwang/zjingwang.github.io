---
title: 关于zetasql的c++ demo
description: 编译c++ demo，然后用java调用
toc: true
authors: onceking
tags: ['zetasql','dp']
categories: ['zetasql','dp']
series:
date: '2023-07-24T16:59:00+08:00'
lastmod: '2023-07-26T09:59:00+08:00'
draft: false
featuredImage: "/images/lufei.png"
---

找到了谷歌差分隐私里的zetasql demo，用的是c++实现的，有点恶心

<!--more-->

## 编译

需要下载bazel，然后就是gcc相关依赖，需要gcc-11，可以参考官方DockerFile，使用镜像编译。

### 使用

```shell
bazel run execute_query -- --data_set=$(pwd)/data/day_data.csv --userid_col=VisitorId \
'SELECT WITH ANONYMIZATION OPTIONS(epsilon=1, delta=1e-5, kappa=1)
   TIME_TRUNC(PARSE_TIME("%I:%M%p", `Time entered`), HOUR) AS `Hour entered`,
   ANON_COUNT(* CLAMPED BETWEEN 0 AND 1) AS `Total Visitors (DP)`
 FROM day_data
 GROUP BY `Hour entered`'
```

### java集成

因为zetasql的java sdk需要JNI，而JNI需要gcc，所以索性在docker里运行了，然后使用java的process builder去调用
