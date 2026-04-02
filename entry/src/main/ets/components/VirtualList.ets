/**
 * 虚拟列表组件
 * 用于高效渲染大量数据
 */

@Component
export struct VirtualList {
  @Prop items: any[];
  @Prop itemBuilder: (item: any, index: number) => void;
  @Prop itemHeight: number;
  @Prop keyExtractor: (item: any) => string;
  @Prop visibleCount: number;

  // 滚动位置
  @State scrollOffset: number = 0;
  // 开始索引
  @State startIndex: number = 0;
  // 结束索引
  @State endIndex: number = 0;

  aboutToAppear() {
    this.calculateVisibleRange();
  }

  build() {
    Scroll() {
      Column() {
        // 占位容器，用于实现滚动高度
        Column()
          .width('100%')
          .height(this.items.length * this.itemHeight)
          .touchable(false);

        // 实际渲染的项目
        Stack() {
          ForEach(this.getVisibleItems(), (item: any, index: number) => {
            Column() {
              this.itemBuilder(item, this.startIndex + index);
            }
            .position({
              x: 0,
              y: (this.startIndex + index) * this.itemHeight
            })
            .width('100%');
          }, (item: any) => this.keyExtractor(item));
        }
        .width('100%')
        .height(this.items.length * this.itemHeight)
        .position({ x: 0, y: 0 });
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .onScroll((offset: number) => {
      this.scrollOffset = offset;
      this.calculateVisibleRange();
    });
  }

  /**
   * 计算可视区域内的项目范围
   */
  private calculateVisibleRange(): void {
    // 计算开始索引
    this.startIndex = Math.max(0, Math.floor(this.scrollOffset / this.itemHeight) - 1);
    // 计算结束索引
    this.endIndex = Math.min(this.items.length - 1, this.startIndex + this.visibleCount + 1);
  }

  /**
   * 获取可视区域内的项目
   */
  private getVisibleItems(): any[] {
    return this.items.slice(this.startIndex, this.endIndex + 1);
  }
}
