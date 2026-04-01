# 📚 鸿蒙读书 APP

一个基于**HarmonyOS（鸿蒙系统）**开发的轻量级读书应用，提供舒适的阅读体验和完整的书籍管理功能。

![HarmonyOS](https://img.shields.io/badge/HarmonyOS-411B95?logo=harmonyos&logoColor=white) ![ETS](https://img.shields.io/badge/ETS-1A1A1A?logoColor=white&color=333)

---

## ✨ 功能特点

### 📖 书本列表页
- 📚 **丰富藏书**：内置 8 本经典文学作品
- 🔍 **智能搜索**：快速查找想读的书籍
- ⭐ **收藏管理**：支持收藏喜欢的书籍
- 🎨 **精美卡片**：优雅的书籍卡片展示

### 📖 阅读器页
- 🌙 **夜间模式**：护眼阅读体验
- 📏 **字号调节**：自由调整字体大小
- 📐 **行距调节**：个性化阅读舒适度
- 📑 **章节目录**：快速定位阅读进度

### ⚙️ 设置页
- 🎨 **主题切换**：深色/浅色主题
- 📱 **阅读偏好**：保存个人阅读设置
- 💾 **数据持久化**：本地存储阅读进度

---

## 📱 界面预览

### 书本列表
```
┌─────────────────────────────────────┐
│ 🔍 搜索书籍...                       │
├─────────────────────────────────────┤
│ ⭐ 收藏     全部                     │
├─────────────────────────────────────┤
│ ┌───────────┐ ┌───────────┐         │
│ │  《活着》  │ │  《三体》  │         │
│ │  余华      │ │  刘慈欣    │         │
│ │  [封面]   │ │  [封面]   │         │
│ └───────────┘ └───────────┘         │
└─────────────────────────────────────┘
```

### 阅读器
```
┌─────────────────────────────────────┐
│ 📑 目录    🌙 夜间    ⚙️ 设置        │
├─────────────────────────────────────┤
│                                     │
│    活着                             │
│                                     │
│    第一章 苦活                      │
│                                     │
│    东镇刚搬来时，家里很穷...        │
│                                     │
│    （正文内容区）                   │
│                                     │
├─────────────────────────────────────┤
│ 📖 字号调节        上一页 下一页     │
└─────────────────────────────────────┘
```

---

## 📖 示例书籍列表

| # | 书名 | 作者 |
|---|------|------|
| 1 | 《活着》 | 余华 |
| 2 | 《三体》 | 刘慈欣 |
| 3 | 《百年孤独》 | 加西亚·马尔克斯 |
| 4 | 《围城》 | 钱钟书 |
| 5 | 《红楼梦》 | 曹雪芹 |
| 6 | 《平凡的世界》 | 路遥 |
| 7 | 《追风筝的人》 | 卡勒德·胡赛尼 |
| 8 | 《白夜行》 | 东野圭吾 |

---

## 🛠️ 技术栈

- **开发语言**：ArkTS (ETS)
- **开发框架**：ArkUI
- **系统要求**：HarmonyOS 4.0+
- **IDE**：DevEco Studio

---

## 📦 项目结构

```
reader-app/
├── src/entry/coreAbility/
│   ├── main/ets/
│   │   ├── pages/
│   │   │   ├── Index.ets         # 书本列表页
│   │   │   ├── Reader.ets        # 阅读器页
│   │   │   └── Settings.ets      # 设置页
│   │   ├── EntryAbility.ets      # 应用入口
│   │   ├── Application.json      # 应用配置
│   │   ├── bookList.json         # 书籍数据
│   │   └── content.json          # 阅读内容
│   └── resources/base/
│       └── rawfile/
│           ├── bookList.json
│           └── content.json
├── build-profile.json5           # 模块配置
├── modules.json5                 # 入口模块配置
├── oh-package.json5              # 依赖配置
└── README.md
```

---

## 🚀 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/tao625/reader-app.git
cd reader-app
```

### 2. 打开项目

在 **DevEco Studio** 中：

```
文件 -> 打开 -> 选择项目文件夹
```

### 3. 同步依赖

在 DevEco Studio 中：

```
HMS 菜单 -> Resolve Dependencies
```

### 4. 运行项目

1. 创建模拟器或连接真机
2. 点击绿色 ▶️ 运行按钮
3. 等待编译完成

---

## 🎯 开发说明

### 页面功能

#### Index.ets (书本列表)
- 展示书籍卡片列表
- 顶部搜索栏
- 收藏/全部筛选按钮

#### Reader.ets (阅读器)
- 显示书籍目录
- 正文内容渲染
- 字号/行距调节
- 夜间模式切换

#### Settings.ets (设置)
- 主题切换（深色/浅色）
- 字体大小设置
- 行距设置
- 阅读偏好保存

---

## 📝 注意事项

### ⚠️ 常见问题

1. **编译失败**
   - 检查所有 `.ets` 文件是否包含 `@Component` 装饰器
   - 执行 `Build -> Clean Project` 后 `Rebuild Project`

2. **依赖下载慢**
   - 在 DevEco Studio 中配置镜像源
   - 使用 HMS 菜单 -> Resolve Dependencies

3. **模拟器无法启动**
   - 检查系统架构（建议 x86_64）
   - 删除旧模拟器后重新创建

---

## 📄 许可证

MIT License

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

## 📮 联系方式

- **GitHub**: [@tao625](https://github.com/tao625)
- **项目地址**: https://github.com/tao625/reader-app

---

<div align="center">

**📚 享受阅读，探索知识的世界**

[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-4.0+-411B95?logo=harmonyos&logoColor=white)](https://developer.harmonyos.com)

</div>
