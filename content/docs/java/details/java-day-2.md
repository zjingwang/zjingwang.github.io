---
title: 记录一下遇到的sql解析器
description: java的一些记录
toc: true
enableComment: true
authors:
  - onceking 
tags: ['java']
categories: ['java']
series:
date: 2023-08-14T17:49:00+08:00
lastmod: 2023-08-14T17:49:00+08:00
featuredImage: "/images/lufei.png"
draft: false
---

## java druid解析器
最近需要将普通sql转化成zetasql以便支持差分隐私，所以看些sql解析器
- 使用druid解析sql语句
    ```java
    try {
            // 创建 SQL 解析器
            DbType dbType = JdbcConstants.MYSQL;
            List<SQLStatement> statementList = SQLUtils.parseStatements(sql, dbType);
            SchemaStatVisitor statVisitor = SQLUtils.createSchemaStatVisitor(dbType);
            for (SQLStatement stmt : statementList) {
                stmt.accept(statVisitor);
            }
            log.info("使用visitor数据表：" + statVisitor.getTables());
            log.info("使用visitor字段：" + statVisitor.getColumns());
            for (TableStat.Column column : statVisitor.getColumns()) {
                if (column.isSelect()){
                    log.info("查询的字段：" + column.getFullName() + "," + column.getName());
                }
            }
            log.info("使用visitor条件：" + statVisitor.getConditions());
            log.info("使用visitor分组：" + statVisitor.getGroupByColumns());
            log.info("使用visitor排序：" + statVisitor.getOrderByColumns());
        } catch (Exception e) {
            e.printStackTrace();
    }
    ```

## Slf4j中文乱码
需要将charset设置成utf-8
```xml
<?xml version="1.0" encoding="UTF-8"?>
```
