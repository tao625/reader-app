import { router } from '@kit.ArkUI'
import { promptAction } from '@kit.ArkUI'
import content from '../rawfile/content.json'
import { ReadingSettings, ReaderTheme, PREDEFINED_THEMES } from '../common/Types'
import { StorageManager } from '../common/StorageManager'

/**
 * 阅读器页面
 * 负责书籍内容的阅读展示
 * API 20 版本
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
  @State private bgColor: ResourceColor = PREDEFINED_THEMES.light.bgColor  // 背景色
  @State private textColor: ResourceColor = PREDEFINED_THEMES.light.textColor // 文字色
  @State private bookId: number = 1              // 当前书籍ID
  @State private scrollPosition: number = 0      // 滚动位置
  @State private isFavorite: boolean = false      // 是否收藏

  // --- 阅读设置 ---
  private readingSettings: ReadingSettings = {
    fontSize: 16,
    lineHeight: 24,
    wordSpacing: 4,
    isNightMode: false
  }

  /**
   * 页面显示时加载设置和阅读进度
   */
  onPageShow(): void {
    this.loadSettings();
  }

  /**
   * 页面隐藏时保存设置和阅读进度
   */
  onPageHide(): void {
    this.saveSettings();
  }

  /**
   * 加载设置和阅读进度
   */
  private async loadSettings(): Promise<void> {
    // 加载阅读设置
    const settings = await StorageManager.getReadingSettings();
    this.fontSize = settings.fontSize;
    this.lineHeight = settings.lineHeight;
    this.isNightMode = settings.isNightMode;
    this.bgColor = this.isNightMode ? '#1a1a1a' : '#FFFFFF';
    this.textColor = this.isNightMode ? '#e0e0e0' : '#333333';

    // 加载阅读进度
    const progress = await StorageManager.getReadingProgress(this.bookId);
    // 这里可以根据进度设置滚动位置

    // 检查书籍是否被收藏
    this.isFavorite = await StorageManager.isFavorite(this.bookId);
  }

  /**
   * 保存设置和阅读进度
   */
  private async saveSettings(): Promise<void> {
    // 保存阅读设置
    const settings: ReadingSettings = {
      fontSize: this.fontSize,
      lineHeight: this.lineHeight,
      wordSpacing: 4,
      isNightMode: this.isNightMode
    };
    await StorageManager.saveReadingSettings(settings);

    // 保存阅读进度（这里使用模拟值，实际应该根据滚动位置计算）
    const progress = 50; // 模拟值
    await StorageManager.saveReadingProgress(this.bookId, progress);
  }

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

      // 目录
      Column() {
        Text('目录')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .margin({ bottom: 8 })
        
        Column() {
          ForEach(content.toc, (tocItem: { title: string, progress: number }, index: number) => {
            Button({
              type: ButtonType.Text,
              width: '100%'
            }) {
              Text(tocItem.title)
                .fontSize(12)
                .fontColor('#FFFFFF')
            }
            .backgroundColor('#444444')
            .padding(6)
            .margin({ bottom: 4 })
            .onClick(() => {
              // 跳转到对应章节
              this.scrollToChapter(index);
              this.showMenu = false;
            })
          })
        }
        .width('100%')
      }
      .width('90%')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })

      // 标记为收藏按钮
      Button({
        type: ButtonType.Text,
        width: '90%'
      }) {
        Text(this.isFavorite ? '取消收藏' : '标记为收藏')
          .fontSize(14)
      }
      .backgroundColor(this.isFavorite ? '#f5f5f5' : '#ff9800')
      .fontColor(this.isFavorite ? '#666' : '#FFFFFF')
      .padding(8)
      .margin({ left: 4, right: 4, top: 4, bottom: 4 })
      .onClick(async () => {
        if (this.isFavorite) {
          await StorageManager.removeFromFavorites(this.bookId);
          this.isFavorite = false;
          promptAction.showToast({
            message: '已从收藏中移除',
            duration: 2000
          });
        } else {
          await StorageManager.addToFavorites(this.bookId);
          this.isFavorite = true;
          promptAction.showToast({
            message: '已添加到收藏',
            duration: 2000
          });
        }
        this.showMenu = false;
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
        Scroll(this.scrollPosition) {
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
                .id(`content-${index}`)
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .onScroll((offset: number) => {
          this.scrollPosition = offset;
        })
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

  /**
   * 跳转到指定章节
   * @param chapterIndex 章节索引
   */
  private scrollToChapter(chapterIndex: number): void {
    // 计算滚动位置（这里使用简单的线性计算，实际应用中可能需要更复杂的计算）
    const chapterHeight = 100; // 假设每个章节的高度
    this.scrollPosition = chapterIndex * chapterHeight;
  }
}
