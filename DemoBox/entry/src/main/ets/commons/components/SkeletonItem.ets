import { LengthMetrics } from "@kit.ArkUI"

@ComponentV2
export struct SkeletonItem {
  @Param widthValue: Length = '100%'
  @Param heightValue: Length = 16
  @Param color: Resource = $r('app.color.common_white_background')
  build() {
    Text()
      .width(this.widthValue)
      .height(this.heightValue)
      .borderRadius(2)
      .backgroundColor(this.color)
  }
}

@ComponentV2
export struct SkeletonOneImageItem {
  build() {
    Row({
      space: 16
    }) {
      Text()
        .width(96)
        .aspectRatio(1)
        .borderRadius(12)
        .backgroundColor($r('app.color.common_gray_background'))

      Column({
        space: 8
      }) {
        Column({
          space: 8
        }){
          SkeletonItem({
            widthValue: '100%',
            color: $r('app.color.common_gray_background')
          })
          SkeletonItem({
            widthValue: '50%',
            color: $r('app.color.common_gray_background')
          })
        }
        .alignItems(HorizontalAlign.Start)

        Flex({
          justifyContent: FlexAlign.Start,
          space: {
            main: LengthMetrics.vp(8)
          }
        }) {
          SkeletonItem({
            widthValue: '20%',
            color: $r('app.color.common_gray_background')
          })
          SkeletonItem({
            widthValue: '20%',
            color: $r('app.color.common_gray_background')
          })
          SkeletonItem({
            widthValue: '20%',
            color: $r('app.color.common_gray_background')
          })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
      .height(96)
      .layoutWeight(1)
    }
    .padding(16)
    .borderRadius(12)
    .backgroundColor($r('app.color.common_white_background'))
  }
}

@ComponentV2
export struct SkeletonTextItem {
  build() {
    Column({
      space: 12
    }){
      SkeletonItem({
        widthValue: '100%',
        color: $r('app.color.common_gray_background')
      })
      SkeletonItem({
        widthValue: '50%',
        color: $r('app.color.common_gray_background')
      })
      Flex({
        justifyContent: FlexAlign.Start,
        space: {
          main: LengthMetrics.vp(8)
        }
      }) {
        SkeletonItem({
          widthValue: '20%',
          color: $r('app.color.common_gray_background')
        })
        SkeletonItem({
          widthValue: '20%',
          color: $r('app.color.common_gray_background')
        })
        SkeletonItem({
          widthValue: '20%',
          color: $r('app.color.common_gray_background')
        })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .borderRadius(12)
    .backgroundColor($r('app.color.common_white_background'))
  }
}