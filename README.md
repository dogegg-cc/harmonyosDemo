
# 今日洞察 (DemoBox)

一个基于HarmonyOS ArkTS V2开发的新闻资讯类应用。
<img width="650" height="750" alt="image" src="https://github.com/user-attachments/assets/791d4e4b-20db-4862-86a7-be04650befc3" />


https://github.com/user-attachments/assets/7d85400d-6572-4e29-ba98-cf512ab58a9e


## 项目简介

**今日洞察**是一个现代化的移动应用，为用户提供丰富的新闻资讯、视频内容和个性化推荐服务。项目采用HarmonyOS最新技术栈，实现了高性能、响应式的用户体验。

### 基本信息

- **应用名称**: 今日洞察
- **包名**: com.example.demobox
- **版本**: 1.0.0 (1000000)
- **开发平台**: HarmonyOS
- **SDK版本**: HarmonyOS 6.0.1
- **目标设备**: Phone

## 功能特性

### 🏠 首页
- 新闻资讯展示
- 多频道切换
- 智能推荐
- 下拉刷新

### 👤 我的
- 用户信息管理
- 设置选项
- 关于应用

## 技术架构

### 技术栈

- **开发语言**: ArkTS
- **UI框架**: ArkUI V2
- **状态管理**: 响应式装饰器体系
- **网络请求**: @ohos/axios
- **构建工具**: hvigor

### 核心特性

- 🚀 **现代化架构**: 采用MVVM模式，组件化开发
- 📱 **响应式设计**: 支持多种屏幕尺寸和方向
- 🔄 **状态管理**: 使用@Local、@ObservedV2等装饰器
- 🌐 **网络层**: 封装HTTP请求，支持拦截器
- 🎯 **性能优化**: 懒加载、图片优化、内存管理

## 项目结构

```
DemoBox/
├── AppScope/                    # 应用级配置
│   ├── app.json5               # 应用配置
│   └── resources/              # 应用资源
├── entry/                      # 主模块
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── pages/          # 页面组件
│   │   │   │   ├── Index.ets   # 主入口
│   │   │   │   ├── Home/       # 首页模块
│   │   │   │   ├── Video/      # 视频模块
│   │   │   │   ├── Follow/     # 关注模块
│   │   │   │   └── Mine/       # 个人中心
│   │   │   ├── commons/        # 公共组件
│   │   │   │   └── utils/      # 工具类
│   │   │   └── ability/        # 能力配置
│   │   ├── module.json5        # 模块配置
│   │   └── resources/          # 模块资源
│   └── build-profile.json5     # 构建配置
├── oh-package.json5            # 依赖管理
└── hvigorfile.ts              # 构建脚本
```

## 快速开始

### 环境要求

- DevEco Studio 4.0 或更高版本
- HarmonyOS SDK 6.0.1
- Node.js 16+ (用于hvigor构建)

### 构建和运行

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd DemoBox
   ```

2. **安装依赖**
   ```bash
   npm install
   ```

3. **构建项目**
   ```bash
   npm run build
   ```

4. **运行调试**
   - 在DevEco Studio中打开项目
   - 连接设备或启动模拟器
   - 点击运行按钮

### 开发指南

#### 添加新页面

1. 在 `entry/src/main/ets/pages/` 下创建新页面组件
2. 在 `module.json5` 中注册页面路由
3. 在 `Index.ets` 中添加导航配置

#### 网络请求

使用封装的HttpClient工具类：

```typescript
import { httpClient } from '../commons/utils/httpClient';

// GET请求
const response = await httpClient.get('/api/news');

// POST请求
const response = await httpClient.post('/api/user', { name: '张三' });
```

#### 状态管理

使用ArkTS V2装饰器进行状态管理：

```typescript
@ComponentV2
struct MyComponent {
  @Local count: number = 0;
  
  build() {
    Column() {
      Text(`计数: ${this.count}`)
      Button('增加')
        .onClick(() => {
          this.count++;
        })
    }
  }
}
```

## 配置说明

### 应用配置 (app.json5)

```json5
{
  "app": {
    "bundleName": "com.example.demobox",
    "vendor": "example",
    "versionCode": 1000000,
    "versionName": "1.0.0"
  }
}
```

### 模块配置 (module.json5)

```json5
{
  "module": {
    "name": "entry",
    "type": "entry",
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET"
      }
    ],
    "abilities": [
      {
        "name": "EntryAbility",
        "srcEntry": "./ets/ability/EntryAbility.ets",
        "description": "$string:EntryAbility_desc",
        "icon": "$media:icon",
        "label": "$string:EntryAbility_label",
        "startWindowIcon": "$media:icon",
        "startWindowBackground": "$color:start_window_background",
        "exported": true,
        "skills": [
          {
            "actions": [
              "action.system.home"
            ],
            "entities": [
              "entity.system.home"
            ]
          }
        ]
      }
    ]
  }
}
```

## 依赖管理

项目使用的主要依赖库：

```json5
{
  "dependencies": {
    "@ohos/axios": "^2.0.0",        // HTTP请求库
    "@abner/log": "^1.0.0",          // 日志工具
    "@ohos/hypium": "^1.0.0"         // 测试框架
  }
}
```
---

**注意**: 本项目为演示用途。
