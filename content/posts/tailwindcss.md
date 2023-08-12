---
title: use tailwind in angular 9
description: 记录一下在angular中使用tailwind
toc: true
enableComment: true
authors:
  - onceking 
tags: ['angular']
categories: ['angular']
series:
date: 2023-08-04T14:57:00+08:00
lastmod: 2023-08-04T14:57:00+08:00
featuredImage: "/images/lufei.png"
draft: false
---

在angular中使用tailwind

- 引入tailwind

```shell
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init
```
- 修改配置文件tailwind.config.js
```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,ts}",
    './projects/**/*.{html,ts}'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```
- 引入样式
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```
- 修改angular.json，引入angular custom-webpack
```json
"architect": {
  "build": {
    "builder": "@angular-builders/custom-webpack:browser",
    "options": {
      "customWebpackConfig": {
        "path": "./extra-webpack.config.js"
      },
      "outputPath": "dist/angular-tailwind",
      ...
    },
  }
},
"serve":{
  "builder": "@angular-builders/custom-webpack:dev-server"
}
```
- 添加extra-webpack.config.js
```js
module.exports = {
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          {
            loader: "postcss-loader",
            options: {
              plugins: [require("tailwindcss")("./tailwind.config.js")]
            }
          }
        ]
      }
    ]
  }
};
```
- 示例
```html
<h1 class="text-2xl m-1 p-3 border-b">Test</h1>
```
- 结果
![Result](/images/tailwindcss.png)

