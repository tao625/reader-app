import router from '@ohos.router'

/**
 * 设置页面
 * 负责用户偏好设置管理
 */
@Route
@Component
struct Settings {
  // --- 用户设置状态 ---
  @State private themeMode: string = 'light'      // 主题模式：light/dark
  @State private defaultFontSize: number = 16     // 默认字体大小
  @State private nightMode: boolean = false       // 夜间模式开关
  @State private soundEnabled: boolean = true     // 音效开关
  @State private autoSleepMinutes: number = 30    // 自动休眠时间（分钟）

  // --- 主题设置区域 ---
  @Builder themeSettings() {
    Column() {
      Text('主题设置')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 夜间模式开关
      this.nightModeBuilder()

      // 主题模式切换按钮
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Row() {
          Text(this.themeMode === 'light' ? '亮色模式' : '深色模式')
            .fontSize(14)
        }
      }
      .backgroundColor(this.themeMode === 'light' ? '#e0e0e0' : '#333333')
      .color(this.themeMode === 'light' ? '#333333' : '#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 12 })
      .onClick(() => {
        this.themeMode = this.themeMode === 'light' ? 'dark' : 'light'
      })
    }
    .width('100%')
    .padding(16)
  }

  // --- 阅读设置区域 ---
  @Builder readingSettings() {
    Column() {
      Text('阅读设置')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 字体大小
      this.fontSizeBuilder()

      // 行距
      this.lineHeightBuilder()

      // 字间距
      this.wordSpacingBuilder()

      // 自动休眠
      this.autoSleepBuilder()

      // 音效开关
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Row() {
          Text(this.soundEnabled ? '阅读音效：开启' : '阅读音效：关闭')
            .fontSize(14)
        }
      }
      .backgroundColor(this.soundEnabled ? '#4CAF50' : '#f5f5f5')
      .color(this.soundEnabled ? '#FFFFFF' : '#333333')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 12 })
      .onClick(() => {
        this.soundEnabled = !this.soundEnabled
      })
    }
    .width('100%')
    .padding(16)
  }

  // --- 存储设置区域 ---
  @Builder storageSettings() {
    Column() {
      Text('存储设置')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 清空缓存按钮
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('清空缓存')
          .fontSize(14)
      }
      .backgroundColor('#f44336')
      .color('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 12 })
      .onClick(() => {
        alert('缓存已清空')
      })
    }
    .width('100%')
    .padding(16)
  }

  // --- 关于应用区域 ---
  @Builder aboutSettings() {
    Column() {
      Text('关于应用')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 应用版本
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Row() {
          Text('应用版本')
            .fontSize(14)
          Text('v1.0.0')
            .fontSize(14)
            .fontColor('#666')
        }
      }
      .backgroundColor('#e0e0e0')
      .color('#333333')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 12 })
      .onClick(() => {
        alert('当前版本：v1.0.0\n\n鸿蒙读书 APP\n一款简洁、优雅的电子阅读器')
      })

      // 应用介绍
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('应用介绍')
          .fontSize(14)
      }
      .backgroundColor('#2196F3')
      .color('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 8 })
      .onClick(() => {
        alert('鸿蒙读书 APP\n\n一款专为鸿蒙系统设计的电子阅读器，提供舒适的阅读体验。\n\n特点：\n- 简洁优雅的界面\n- 丰富的主题设置\n- 舒适的阅读排版\n- 收藏功能')
      })
    }
    .width('100%')
    .padding(16)
  }

  // --- 夜间模式组件 ---
  @Builder nightModeBuilder() {
    Row() {
      Text('夜间模式')
        .fontSize(12)
        .fontColor('#999')
      Toggle({ value: this.nightMode })
        .padding({ top: 4, bottom: 4 })
        .onValueChange((newVal) => {
          this.nightMode = newVal
        })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 字体大小组件 ---
  @Builder fontSizeBuilder() {
    Column() {
      Text('字号')
        .fontSize(14)
        .fontColor('#999')
      Row() {
        Slider({
          value: this.defaultFontSize,
          min: 12,
          max: 32,
          step: 1
        })
          .width('85%')
          .onChange((value) => {
            this.defaultFontSize = value
          })
        Text({
          text: `${this.defaultFontSize}px`,
          fontSize: 12,
          fontColor: '#666'
        })
      }
      .width('100%')
      .padding({ top: 4, bottom: 8 })
      Text(`当前字体大小：${this.defaultFontSize}px`)
        .fontSize(12)
        .fontColor('#666')
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 行距组件 ---
  @Builder lineHeightBuilder() {
    Column() {
      Text('行距')
        .fontSize(14)
        .fontColor('#999')
      Row() {
        Slider({
          value: 16,
          min: 16,
          max: 48,
          step: 2
        })
          .width('85%')
        Text('默认 16px')
          .fontSize(12)
          .fontColor('#666')
      }
      .width('100%')
      .padding({ top: 4, bottom: 8 })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 字间距组件 ---
  @Builder wordSpacingBuilder() {
    Column() {
      Text('字间距')
        .fontSize(14)
        .fontColor('#999')
      Row() {
        Slider({
          value: 4,
          min: 2,
          max: 10,
          step: 1
        })
          .width('85%')
        Text('默认 4px')
          .fontSize(12)
          .fontColor('#666')
      }
      .width('100%')
      .padding({ top: 4, bottom: 8 })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 自动休眠组件 ---
  @Builder autoSleepBuilder() {
    Column() {
      Text('自动休眠')
        .fontSize(14)
        .fontColor('#999')
      Row() {
        Slider({
          value: this.autoSleepMinutes,
          min: 5,
          max: 120,
          step: 5
        })
          .width('85%')
          .onChange((value) => {
            this.autoSleepMinutes = value
          })
        Text({
          text: `${this.autoSleepMinutes}分钟后自动休眠`,
          fontSize: 12,
          fontColor: '#666'
        })
      }
      .width('100%')
      .padding({ top: 4, bottom: 8 })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  build() {
    Column() {
      // --- 顶部标题 ---
      Text('设置')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 20, bottom: 10 })

      // --- 主题设置 ---
      this.themeSettings()

      // --- 阅读设置 ---
      this.readingSettings()

      // --- 存储设置 ---
      this.storageSettings()

      // --- 关于应用 ---
      this.aboutSettings()

      // --- 底部返回按钮 ---
      Row() {
        Button('返回')
          .fontSize(14)
          .width('40%')
          .click(() => {
            router.pushUrl({
              url: {
                page: 'pages/Index'
              }
            })
          })
        Divider()
          .width('60%')
          .backgroundColor('#e0e0e0')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
