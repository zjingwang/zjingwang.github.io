---
title: 使用bazel将c++编译成so文件
description: 编译c++ demo，然后用java调用编译出的so文件
toc: true
authors: onceking
tags: ['zetasql','dp']
categories: ['zetasql','dp']
series: ['zetasql','dp']
date: '2023-07-27T14:40:00+08:00'
lastmod: '2023-07-27T14:40:00+08:00'
draft: false
featuredImage: "/images/lufei.png"
---

因为之前用的docker太大，大概几个G，现在想着将c++代码编译成so文件吗，然后使用JNA调用，从而避免gcc的依赖。

<!--more-->

## 编译
修改BUILD文件，之前是将c++编译成二进制的
```c
name = "execute_query.so",
    srcs = [
        "execute_query.cc",
    ],
    linkshared=True,
```

```shell
bazelisk build execute_query.so
```

### 结果

```shell
./execute_query.so: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by ./execute_query.so)
./execute_query.so: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by ./execute_query.so)
./execute_query.so: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.30' not found (required by ./execute_query.so)
./execute_query.so: /lib64/libm.so.6: version `GLIBC_2.29' not found (required by ./execute_query.so)
        linux-vdso.so.1 (0x00007ffed8c33000)
        /opt/ZTE-UDS-DRM/libftagtctr.so (0x00007ff4806fe000)
        libpthread.so.0 => /lib64/libpthread.so.0 (0x00007ff4804de000)
        libm.so.6 => /lib64/libm.so.6 (0x00007ff48015c000)
        libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007ff47fdc7000)
        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007ff47fbaf000)
        libc.so.6 => /lib64/libc.so.6 (0x00007ff47f7ec000)
        /lib64/ld-linux-x86-64.so.2 (0x00007ff4877e0000)
```
还是需要gcc啊！！！还得再找其他方法
### java集成
集成不了了怕是

