import router from '@ohos.router'
import content from '@resource/content.json'

/**
 * 阅读器页面
 * 负责书籍内容的阅读展示
 */
@Route
@Component
struct Reader {
  // --- 阅读状态 ---
  @State private fontSize: number = 16           // 字体大小
  @State private lineHeight: number = 24         // 行距
  @State private nightMode: boolean = false       // 夜间模式
  @State private currentTitle: string = ''        // 当前书籍标题
  @State private showMenu: boolean = false        // 侧边菜单显示状态
  @State private menuPosition: number = 20        // 侧边菜单位置（百分比）

  // --- 主题配置 ---
  @Builder nightMode() {
    Row() {
      Text('夜读模式')
        .fontSize(12)
        .fontColor('#999')
      Toggle({ value: this.nightMode })
        .fontSize(12)
        .padding({ top: 4, bottom: 4 })
        .onValueChange((newVal) => {
          this.nightMode = newVal
          this.bgColor = newVal ? Color('#1a1a1a') : Color('#FFFFFF')
          this.textColor = newVal ? Color('#e0e0e0') : Color('#333333')
        })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 字体大小设置 ---
  @Builder fontSize() {
    Row() {
      Text('字体大小')
        .fontSize(12)
        .fontColor('#999')
      Slider({
        value: this.fontSize,
        min: 12,
        max: 32,
        step: 1
      })
        .width('60%')
        .onChange((value) => {
          this.fontSize = value
        })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 行距设置 ---
  @Builder lineHeight() {
    Row() {
      Text('行距')
        .fontSize(12)
        .fontColor('#999')
      Slider({
        value: this.lineHeight,
        min: 16,
        max: 48,
        step: 2
      })
        .width('60%')
        .onChange((value) => {
          this.lineHeight = value
        })
    }
    .width('100%')
    .height(44)
    .padding(0, 8)
  }

  // --- 侧边菜单 ---
  @Builder sideMenu() {
    Column() {
      // 阅读设置按钮
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('阅读设置')
          .fontSize(14)
      }
      .backgroundColor('#333333')
      .color('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(() => {
        this.showMenu = !this.showMenu
      })

      // 目录按钮（模拟）
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('目录')
          .fontSize(14)
      }
      .backgroundColor(this.showMenu ? '#e0e0e0' : '#f5f5f5')
      .color(this.showMenu ? '#333333' : '#999999')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(() => {
        // TODO: 实现目录跳转
        this.showMenu = false
      })

      // 标记为收藏按钮（模拟）
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('标记为收藏')
          .fontSize(14)
      }
      .backgroundColor(this.showMenu ? '#ff9800' : '#f44336')
      .color('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(() => {
        // TODO: 实现收藏功能
        this.showMenu = false
        alert('已添加到书架')
      })
    }
    .width('180%')
    .backgroundColor('#333333')
    .borderRadius(16)
    .padding(8)
  }

  build() {
    // 获取路由参数中的 bookId
    let bookId = router.getParas(this).bookId
    if (bookId && bookId.toString()) {
      this.currentTitle = `书籍 ${bookId}`
    }

    Column() {
      // --- 侧边栏遮罩 ---
      if (this.showMenu) {
        Row() {
          Image()
            .fillColor(Color('#333'))
            .width('50%')
          Column() {
            this.sideMenu()
            Divider()
              .height('10%')
            Divider()
              .width('50%')
              .backgroundColor('#50333333')
          }
          Image()
            .fillColor(Color('#333'))
            .width('50%')
        }
        .width('100%')
        .height('100%')
      }

      // --- 内容区域 ---
      Column() {
        // 标题
        Text({
          text: this.currentTitle,
          font: Font('normal', 'normal')
        })
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .padding({ top: 20, bottom: 10 })

        // 目录（模拟）
        Text({
          text: content.toc.map((toc: any) => {
            return ` - ${toc.title} (${toc.progress}页)`
          }).join('\n'),
          font: Font('normal', 'normal')
        })
          .fontSize(14)
          .fontColor(this.textColor)
          .padding({ top: 0, bottom: 10 })
          .width('100%')

        // 正文内容
        this.contentText
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)
      .fontColor(this.textColor)
    }
    .width('100%')
    .height('100%')
  }

  // --- 正文内容构建 ---
  @Builder
  contentText() {
    Column() {
      // 遍历内容数据渲染
      for (let index in content.content) {
        Text({
          text: content.content[index]
        })
          .fontSize(this.fontSize)
          .lineHeight(this.lineHeight)
          .fontColor(this.textColor)
          .backgroundColor(this.bgColor)
          .margin({ bottom: 10 })
      }
    }
    .width('100%')
    .padding(20)
  }
}
