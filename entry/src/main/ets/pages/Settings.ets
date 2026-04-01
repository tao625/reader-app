import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

/**
 * 设置页面
 * 负责用户偏好设置管理
 */
@Entry
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
        .fontWeight(FontWeight.Bold)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 夜间模式开关
      this.nightModeBuilder()

      // 主题模式切换按钮
      Button(this.themeMode === 'light' ? '亮色模式' : '深色模式')
        .type(ButtonType.Normal)
        .width('90%')
        .backgroundColor(this.themeMode === 'light' ? '#e0e0e0' : '#333333')
        .fontColor(this.themeMode === 'light' ? '#333333' : '#FFFFFF')
        .padding(8)
        .margin({ top: 8 })
        .onClick(() => {
          this.themeMode = this.themeMode === 'light' ? 'dark' : 'light'
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8, left: 12, right: 12 })
  }

  // --- 阅读设置区域 ---
  @Builder readingSettings() {
    Column() {
      Text('阅读设置')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
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
      Button(this.soundEnabled ? '阅读音效：开启' : '阅读音效：关闭')
        .type(ButtonType.Normal)
        .width('90%')
        .backgroundColor(this.soundEnabled ? '#4CAF50' : '#f5f5f5')
        .fontColor(this.soundEnabled ? '#FFFFFF' : '#333333')
        .padding(8)
        .margin({ top: 8 })
        .onClick(() => {
          this.soundEnabled = !this.soundEnabled
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8, left: 12, right: 12 })
  }

  // --- 存储设置区域 ---
  @Builder storageSettings() {
    Column() {
      Text('存储设置')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 清空缓存按钮
      Button('清空缓存')
        .type(ButtonType.Normal)
        .width('90%')
        .backgroundColor('#f44336')
        .fontColor('#FFFFFF')
        .padding(8)
        .margin({ top: 8 })
        .onClick(() => {
          promptAction.showToast({ message: '缓存已清空' })
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8, left: 12, right: 12 })
  }

  // --- 关于应用区域 ---
  @Builder aboutSettings() {
    Column() {
      Text('关于应用')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
      Divider()
        .width('90%')
        .margin({ top: 12, bottom: 8 })

      // 应用版本
      Button('应用版本：v1.0.0')
        .type(ButtonType.Normal)
        .width('90%')
        .backgroundColor('#e0e0e0')
        .fontColor('#333333')
        .padding(8)
        .margin({ top: 8 })
        .onClick(() => {
          promptAction.showToast({ message: '当前版本：v1.0.0' })
        })

      // 应用介绍
      Button('应用介绍')
        .type(ButtonType.Normal)
        .width('90%')
        .backgroundColor('#2196F3')
        .fontColor('#FFFFFF')
        .padding(8)
        .margin({ top: 8 })
        .onClick(() => {
          promptAction.showToast({ message: '鸿蒙读书 APP' })
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ top: 8, left: 12, right: 12 })
  }

  // --- 夜间模式组件 ---
  @Builder nightModeBuilder() {
    Row() {
      Text('夜间模式')
        .fontSize(14)
        .fontColor('#333')
        .layoutWeight(1)
      Toggle({ value: this.nightMode })
        .onChange((newVal: boolean) => {
          this.nightMode = newVal
        })
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }

  // --- 字体大小组件 ---
  @Builder fontSizeBuilder() {
    Column() {
      Row() {
        Text('字号')
          .fontSize(14)
          .fontColor('#666')
          .layoutWeight(1)
        Text(`${this.defaultFontSize}px`)
          .fontSize(14)
          .fontColor('#666')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Slider({
        value: this.defaultFontSize,
        min: 12,
        max: 32,
        step: 1
      })
        .width('100%')
        .onChange((value: number) => {
          this.defaultFontSize = value
        })
    }
    .width('100%')
  }

  // --- 行距组件 ---
  @Builder lineHeightBuilder() {
    Column() {
      Row() {
        Text('行距')
          .fontSize(14)
          .fontColor('#666')
          .layoutWeight(1)
        Text(`${this.defaultFontSize + 8}px`)
          .fontSize(14)
          .fontColor('#666')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Slider({
        value: this.defaultFontSize + 8,
        min: 16,
        max: 48,
        step: 2
      })
        .width('100%')
    }
    .width('100%')
  }

  // --- 字间距组件 ---
  @Builder wordSpacingBuilder() {
    Column() {
      Row() {
        Text('字间距')
          .fontSize(14)
          .fontColor('#666')
          .layoutWeight(1)
        Text('4px')
          .fontSize(14)
          .fontColor('#666')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Slider({
        value: 4,
        min: 2,
        max: 10,
        step: 1
      })
        .width('100%')
    }
    .width('100%')
  }

  // --- 自动休眠组件 ---
  @Builder autoSleepBuilder() {
    Column() {
      Row() {
        Text('自动休眠')
          .fontSize(14)
          .fontColor('#666')
          .layoutWeight(1)
        Text(`${this.autoSleepMinutes}分钟`)
          .fontSize(14)
          .fontColor('#666')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Slider({
        value: this.autoSleepMinutes,
        min: 5,
        max: 120,
        step: 5
      })
        .width('100%')
        .onChange((value: number) => {
          this.autoSleepMinutes = value
        })
    }
    .width('100%')
  }

  build() {
    Column() {
      // --- 顶部标题 ---
      Row() {
        Button('返回')
          .fontSize(14)
          .onClick(() => {
            router.back()
          })
        Text('设置')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Text('')
          .width(60)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')

      // --- 滚动区域 ---
      Scroll() {
        Column() {
          // --- 主题设置 ---
          this.themeSettings()

          // --- 阅读设置 ---
          this.readingSettings()

          // --- 存储设置 ---
          this.storageSettings()

          // --- 关于应用 ---
          this.aboutSettings()

          // 底部间距
          Row().height(20)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F5F5F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
