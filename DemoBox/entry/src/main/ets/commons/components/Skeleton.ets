@ComponentV2
export struct Skeleton {
  @Local opacityValue: number = 1

  @Builder
  DefaultBuilder() {
  }

  @BuilderParam default: () => void = this.DefaultBuilder

  build() {
    List() {
      ListItem(){
        this.default()
      }
    }
    .height('100%')
    .width('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .opacity(this.opacityValue)
    .animation({
      duration: 600,
      iterations: -1,
      playMode: PlayMode.Alternate, // 来回执行
      curve: Curve.Linear
    })
    .onAppear(() => {
      // 组件渲染好
      this.opacityValue = 0.5
    })
  }
}