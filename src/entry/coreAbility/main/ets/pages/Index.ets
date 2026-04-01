import bookList from '@resource/bookList.json'

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
  @State private bookListData: BookInfo[] = bookList

  // 构建页面布局
  build() {
    Column() {
      // --- 顶部搜索栏 ---
      Row() {
        Text('搜索书籍')
          .fontSize(14)
          .fontColor('#666')
          .margin({ left: 8, right: 12 })

        // 搜索输入框
        Input({
          value: this.searchQuery,
          placeholder: '搜索书名/作者',
          placeholderFontColor: Color('#999'),
          fontColor: Color('#333'),
          fontSize: 16
        })
        .width('80%')
        .onChange((value) => {
          this.searchQuery = value
        })
      }
      .padding({ top: 12, bottom: 8 })
      .width('100%')

      // --- 筛选按钮栏 ---
      Row() {
        // 全部按钮
        Button({
          type: ButtonType.Text,
          alignment: Alignment.Start,
          width: '45%'
        }) {
          Text(this.showFavorites ? '全部' : '全部')
            .fontSize(14)
            .fontColor(this.showFavorites ? '#2196F3' : '#666')
            .strokeWidth(1.5)
            .strokeColor(this.showFavorites ? '#2196F3' : 'transparent')
            .textAlign(TextAlign.Center)
        }

        // 书架（收藏）按钮
        Button({
          type: ButtonType.Text,
          alignment: Alignment.End,
          width: '50%'
        }) {
          Text(this.showFavorites ? '书架' : '书架')
            .fontSize(14)
            .fontColor(this.showFavorites ? '#2196F3' : '#666')
            .strokeWidth(1.5)
            .strokeColor(this.showFavorites ? '#2196F3' : 'transparent')
            .textAlign(TextAlign.Center)
        }
      }
      .padding({ top: 8, bottom: 16 })
      .width('100%')

      // --- 搜索结果显示 ---
      // 搜索后过滤书籍列表
      let filteredBooks = this.searchQuery.length > 0
        ? this.bookListData.filter(book =>
            book.title.includes(this.searchQuery) ||
            book.author.includes(this.searchQuery)
          )
        : this.bookListData

      // 根据筛选条件显示书籍
      if (this.showFavorites && this.bookListData.length > 0) {
        // 显示收藏书籍
        for (let book of this.bookListData) {
          if (book.category === 'favorite') {
            BookCard({ book })
          }
        }
      } else {
        // 显示全部书籍或搜索结果
        for (let book of filteredBooks) {
          BookCard({ book })
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(Color('#F5F5F7'))
  }
}

/**
 * 书本卡片组件
 * @param book 书籍信息对象
 */
@Builder
function BookCard(book: BookInfo) {
  Row() {
    // 书籍封面
    Image({
      src: book.cover,
      scaleMode: ImageFit
    })
    .width(100)
    .height(140)
    .borderRadius(6)

    // 书籍信息
    Column() {
      Text(book.title)
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333')
        .lineHeight(20)
      Text(book.author)
        .fontSize(13)
        .fontColor('#999')
        .lineHeight(16)
      Text(book.category)
        .fontSize(11)
        .fontColor('#2196F3')
        .padding(4)
        .backgroundColor('#E3F2FD')
        .borderRadius(4)
    }
  }
  .padding(12)
}
