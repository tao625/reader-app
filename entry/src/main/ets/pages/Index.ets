import bookList from '../../rawfile/bookList.json'
import router from '@ohos.router'

// 书本信息类型定义
interface BookInfo {
  id: number
  title: string
  author: string
  cover: string
  category: string
  progress: number
}

// 页面状态
@Entry
@Component
struct Index {
  // 搜索查询状态
  @State private searchQuery: string = ''

  // 筛选状态：显示收藏书籍
  @State private showFavorites: boolean = false

  // 书籍列表数据
  private bookListData: BookInfo[] = bookList.books

  // 构建页面布局
  build() {
    Column() {
      // --- 顶部标题栏 ---
      Row() {
        Text('书架')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
        Button('设置')
          .fontSize(14)
          .onClick(() => {
            router.pushUrl({ url: 'pages/Settings' })
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      // --- 顶部搜索栏 ---
      Row() {
        Text('搜索书籍')
          .fontSize(14)
          .fontColor('#666')
          .margin({ left: 8, right: 12 })

        // 搜索输入框
        Input({
          placeholder: '搜索书名/作者',
          placeholderFont: { size: 16 }
        })
          .width('70%')
          .onChange((value: string) => {
            this.searchQuery = value
          })
      }
      .padding({ top: 12, bottom: 12 })
      .width('100%')
      .backgroundColor('#FFFFFF')

      // --- 筛选按钮栏 ---
      Row() {
        // 全部按钮
        Button('全部')
          .type(ButtonType.Normal)
          .width('45%')
          .backgroundColor(this.showFavorites ? '#F5F5F5' : '#2196F3')
          .fontColor(this.showFavorites ? '#666' : '#FFFFFF')
          .onClick(() => {
            this.showFavorites = false
          })

        // 书架（收藏）按钮
        Button('收藏')
          .type(ButtonType.Normal)
          .width('45%')
          .backgroundColor(this.showFavorites ? '#2196F3' : '#F5F5F5')
          .fontColor(this.showFavorites ? '#FFFFFF' : '#666')
          .onClick(() => {
            this.showFavorites = true
          })
      }
      .padding({ top: 8, bottom: 16 })
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // --- 书籍列表 ---
      Scroll() {
        Column() {
          // 搜索后过滤书籍列表
          let filteredBooks = this.searchQuery.length > 0
            ? this.bookListData.filter(book =>
                book.title.includes(this.searchQuery) ||
                book.author.includes(this.searchQuery)
              )
            : this.bookListData

          // 根据筛选条件显示书籍
          ForEach(filteredBooks, (book: BookInfo) => {
            // 如果显示收藏，只显示收藏的书籍
            if (!this.showFavorites || book.category === 'favorite') {
              BookCard({ book })
            }
          }, (book: BookInfo) => book.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}

/**
 * 书本卡片组件
 * @param book 书籍信息对象
 */
@Component
struct BookCard {
  @Prop book: BookInfo

  build() {
    Row() {
      // 书籍封面占位符
      Text(book.title.substring(0, 2))
        .width(80)
        .height(110)
        .fontSize(24)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .backgroundColor('#2196F3')
        .borderRadius(6)

      // 书籍信息
      Column() {
        Text(book.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(book.author)
          .fontSize(14)
          .fontColor('#666')
          .margin({ top: 4 })
        Text(book.category === 'favorite' ? '已收藏' : '推荐')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(book.category === 'favorite' ? '#ff9800' : '#2196F3')
          .borderRadius(4)
          .margin({ top: 8 })

        // 阅读进度条
        Row() {
          Text(`阅读进度：${book.progress}%`)
            .fontSize(12)
            .fontColor('#999')
        }
        .width('100%')
        .margin({ top: 8 })

        // 阅读按钮
        Button('开始阅读')
          .fontSize(12)
          .width('80%')
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Reader',
              params: { bookId: this.book.id }
            })
          })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({ left: 12 })
    }
    .padding(12)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .margin({ bottom: 12 })
  }
}
