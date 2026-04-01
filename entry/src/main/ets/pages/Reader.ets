import router from '@ohos.router'
import content from '../rawfile/content.json'

/**
 * 阅读器页面
 * 负责书籍内容的阅读展示
 */
@Entry
@Component
struct Reader {
  // --- 阅读状态 ---
  @State private fontSize: number = 16           // 字体大小
  @State private lineHeight: number = 24         // 行距
  @State private isNightMode: boolean = false    // 夜间模式
  @State private currentTitle: string = '活着'    // 当前书籍标题
  @State private showMenu: boolean = false        // 侧边菜单显示状态
  @State private bgColor: ResourceColor = '#FFFFFF'  // 背景色
  @State private textColor: ResourceColor = '#333333' // 文字色

  // --- 主题配置 ---
  @Builder nightModeBuilder() {
    Row() {
      Text('夜读模式')
        .fontSize(12)
        .fontColor('#999')
      Toggle({ value: this.isNightMode })
        .fontSize(12)
        .padding({ top: 4, bottom: 4 })
        .onValueChange((newVal: boolean) => {
          this.isNightMode = newVal
          this.bgColor = newVal ? '#1a1a1a' : '#FFFFFF'
          this.textColor = newVal ? '#e0e0e0' : '#333333'
        })
    }
    .width('100%')
    .height(44)
    .padding({ left: 8, right: 8 })
  }

  // --- 字体大小设置 ---
  @Builder fontSizeBuilder() {
    Row() {
      Text('字体大小')
        .fontSize(12)
        .fontColor(this.textColor)
      Slider({
        value: this.fontSize,
        min: 12,
        max: 32,
        step: 1
      })
        .width('60%')
        .onChange((value: number) => {
          this.fontSize = value
        })
    }
    .width('100%')
    .height(44)
    .padding({ left: 8, right: 8 })
  }

  // --- 行距设置 ---
  @Builder lineHeightBuilder() {
    Row() {
      Text('行距')
        .fontSize(12)
        .fontColor(this.textColor)
      Slider({
        value: this.lineHeight,
        min: 16,
        max: 48,
        step: 2
      })
        .width('60%')
        .onChange((value: number) => {
          this.lineHeight = value
        })
    }
    .width('100%')
    .height(44)
    .padding({ left: 8, right: 8 })
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
      .fontColor('#FFFFFF')
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
      .fontColor(this.showMenu ? '#333333' : '#999999')
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
      .fontColor('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(() => {
        // TODO: 实现收藏功能
        this.showMenu = false
        AlertDialog.show({
          title: '提示',
          message: '已添加到书架'
        })
      })

      Divider()

      // 夜间模式
      this.nightModeBuilder()

      // 字体大小
      this.fontSizeBuilder()

      // 行距
      this.lineHeightBuilder()

      Divider()

      // 关闭菜单按钮
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text('关闭')
          .fontSize(14)
      }
      .backgroundColor('#666666')
      .fontColor('#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(() => {
        this.showMenu = false
      })
    }
    .width('180')
    .backgroundColor('#333333')
    .borderRadius(16)
    .padding(8)
  }

  build() {
    Stack() {
      // --- 内容区域 ---
      Column() {
        // 标题栏
        Row() {
          Button('返回')
            .fontSize(14)
            .onClick(() => {
              router.back()
            })
          Text(this.currentTitle)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.textColor)
            .layoutWeight(1)
          Button('菜单')
            .fontSize(14)
            .onClick(() => {
              this.showMenu = !this.showMenu
            })
        }
        .width('100%')
        .padding(12)
        .backgroundColor(this.bgColor)

        // 目录（模拟）
        Text(this.tocText)
          .fontSize(14)
          .fontColor(this.textColor)
          .padding({ top: 10, bottom: 10, left: 16, right: 16 })

        // 正文内容
        Scroll() {
          Column() {
            ForEach(content.content, (text: string, index: number) => {
              Text(text)
                .fontSize(this.fontSize)
                .lineHeight(this.lineHeight)
                .fontColor(this.textColor)
                .backgroundColor(this.bgColor)
                .margin({ bottom: 10 })
                .width('100%')
                .padding({ left: 16, right: 16 })
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)

      // --- 侧边栏遮罩和菜单 ---
      if (this.showMenu) {
        Row() {
          // 半透明遮罩
          Row()
            .width('50%')
            .height('100%')
            .backgroundColor('rgba(0, 0, 0, 0.3)')
            .onClick(() => {
              this.showMenu = false
            })

          // 侧边菜单
          Column() {
            this.sideMenu()
          }
          .width('50%')
          .height('100%')
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }

  // 获取目录文本
  private get tocText(): string {
    return content.toc.map((toc: { title: string, progress: number }) => {
      return `- ${toc.title} (第${toc.progress}页)`
    }).join('\n')
  }
}
