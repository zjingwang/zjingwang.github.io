---
title: java一些记录
description: 记录一下遇到的一些修饰器
toc: true
enableComment: true
authors:
  - onceking 
tags: ['java']
categories: ['java']
series:
date: 2023-08-12T09:26:00+08:00
lastmod: 2023-08-12T09:26:00+08:00
featuredImage: "/images/lufei.png"
draft: false
---

### java springboot 跨域的问题
- 在控制类上加 @CrossOrigin 修饰符
    ```java
    @CrossOrigin(origins = "*", maxAge = 3600)
    public class DpController {
    }
    ``` 
- 更小的颗粒度，可以在路由上加@CrossOrigin
    ```java
    @CrossOrigin(origins = "*", maxAge = 3600)
    @RequestMapping(value = "/sql", method = RequestMethod.POST)
    @ResponseBody
    public Result executeSql(@RequestBody SqlParams sqlParams) {
    }
    ```

### 异常处理
如果想给前端返回自定义的错误，可以使用全局的异常处理器:
```java
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(DpException.class)
    public ResponseEntity<String> handleDpException(DpException ex) {
        String errorMessage = ex.getMessage();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
    }

}

```
这样当 
``` java 
throw new DpException("some error");
``` 
的时候就能把报错信息返回给前端
