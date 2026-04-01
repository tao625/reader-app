# 鸿蒙读书 APP - DevEco Studio 快速启动指南

## 第一步：用 DevEco Studio 打开项目

### 方法一：直接打开
1. 启动 DevEco Studio
2. 点击 `File` -> `Open`
3. 选择 `reader-app` 文件夹
4. 点击 `Open`

### 方法二：新建项目导入
1. 点击 `File` -> `New` -> `Project from Existing Code`
2. 选择项目路径：`e:\mycode\my-project\reader-app`
3. 完成导入

---

## 第二步：同步项目

项目打开后，DevEco Studio 会自动：
1. 下载 `oh-package.json5` 中的依赖包
2. 同步模块配置
3. 编译项目

**如果看到同步进度条，请耐心等待...**

---

## 第三步：配置模拟器

### 创建鸿蒙模拟器
1. `Device Manager` -> `Create Device`
2. 选择模拟器类型（建议：`Phone` 类型）
3. 选择 SDK 版本（建议：API 9 或更高）
4. 点击 `Create`

### 启动模拟器
1. 在 DevEco Studio 工具栏点击 `Device Manager`
2. 右键点击创建的模拟器 -> `Start`

---

## 第四步：运行项目

### 方法一：快速运行
1. 点击工具栏的绿色 ▶️ 运行按钮
2. 或者按快捷键 `Shift + F10`

### 方法二：选择设备运行
1. 从设备下拉框选择模拟器或真机
2. 点击运行按钮

---

## 项目运行结果预期

### 启动页面
- 显示书本列表卡片
- 包含 8 本示例书籍
- 顶部有搜索栏和筛选按钮

### 点击书籍后
- 进入阅读器页面
- 显示书籍标题和目录
- 正文内容可读

### 点击设置后
- 可调整字体大小、行距
- 切换夜间模式

---

## 常见问题解决

### 问题 1：提示 `oh-package.json5` 找不到
**解决方案：**
- 确保项目根目录有 `oh-package.json5` 文件
- 点击 `HMS` 菜单 -> `Resolve Dependencies`

### 问题 2：编译错误
**解决方案：**
- 检查所有 `.ets` 文件是否正确保存
- 点击 `Build` -> `Clean Project`
- 再点击 `Build` -> `Rebuild Project`

### 问题 3：模拟器无法启动
**解决方案：**
- 检查系统架构是否匹配（建议 x86_64）
- 确保有足够的磁盘空间
- 删除旧模拟器后重新创建

### 问题 4：依赖包下载慢
**解决方案：**
- 在 `Project` -> `Preferences` 中配置镜像源
- 或使用离线依赖包

---

## 真机调试

### 连接真机
1. 开启手机的 **USB 调试** 模式
2. 用数据线连接电脑
3. DevEco Studio 会自动识别设备
4. 选择设备后点击运行

### 授权调试
首次连接需要手机授权，点击 `允许 USB 调试`

---

## 项目文件说明

| 文件 | 说明 |
|------|------|
| `src/entry/core/main/ets/EntryAbility.ets` | 应用入口 |
| `src/entry/core/main/ets/pages/Index.ets` | 书本列表页 |
| `src/entry/core/main/ets/pages/Reader.ets` | 阅读器页 |
| `src/entry/core/main/ets/pages/Settings.ets` | 设置页 |
| `oh-package.json5` | 项目依赖配置 |

---

## 开始阅读吧！

运行成功后，你就可以：
- 📚 浏览推荐书籍和收藏书籍
- 🔍 搜索你喜欢的书籍
- 📖 进入阅读器舒适阅读
- ⚙️ 自定义阅读体验

祝阅读愉快！📚✨
