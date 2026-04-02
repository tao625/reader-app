/**
 * 滑块设置组件
 * 用于统一处理滑块类型的设置项
 */

/**
 * 滑块设置组件
 * @param label 设置标签
 * @param value 当前值
 * @param min 最小值
 * @param max 最大值
 * @param step 步长
 * @param unit 单位
 * @param onValueChange 值变化回调
 */
@Component
export struct SliderSetting {
  @Prop label: string;
  @Prop value: number;
  @Prop min: number;
  @Prop max: number;
  @Prop step: number;
  @Prop unit: string;
  @Prop onValueChange: (value: number) => void;
  @Prop textColor: ResourceColor;

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(14)
          .fontColor(this.textColor)
          .layoutWeight(1);
        Text(`${this.value}${this.unit}`)
          .fontSize(14)
          .fontColor(this.textColor);
      }
      .width('100%')
      .margin({ bottom: 8 });

      Slider({
        value: this.value,
        min: this.min,
        max: this.max,
        step: this.step
      })
        .width('100%')
        .onChange((value: number) => {
          this.onValueChange(value);
        });
    }
    .width('100%');
  }
}
