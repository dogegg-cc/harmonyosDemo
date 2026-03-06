import { fullScreen } from "../../commons/utils/fullScreen"
import { logger } from "../../commons/utils/logger"
import { HomeNewsListView } from "../Home/View/HomeNewsListView"
import { MenuItem, MineTabItem, MOCK_MENUITEM, MOCK_MINE_TAB_ITEMS } from "./Model/index"
import { retrieval } from "@kit.DataAugmentationKit"

@Preview
@ComponentV2
export struct MinePage {
  @Local menuItems: MenuItem[] = MOCK_MENUITEM
  @Local activeIndex: number = 0
  @Local tabs: MineTabItem[] = MOCK_MINE_TAB_ITEMS
  @Local headerHeight: number = 144
  @Local listTopOffset: number = 0
  @Local opacityValue: number = 1
  private scroller: ListScroller = new ListScroller();

  build() {
    Column() {
      this.createHeaderView()
      List({
        scroller: this.scroller
      }){
        this.createMenuView()
        this.createBannerView()
        this.createTabListView()
      }
      .height('100%')
      .width('100%')
      .scrollBar(BarState.Off)
      .sticky(StickyStyle.Header)
      .onDidScroll((offset: number, state: ScrollState)=>{
        this.listDidScroll()
      })
      .offset({
        top:this.listTopOffset
      })
    }
    .height('100%')
    .width('100%')
    .onVisibleAreaChange([0.0, 1.0], (isExpanding: boolean, currentRatio: number) => {
      // 页面显示
      if (isExpanding && currentRatio >= 1.0) {
        fullScreen.setLightBar()
      }
      // 页面不显示
      if (!isExpanding && currentRatio <= 0.0) {
        fullScreen.setDarkBar()
      }
    })
  }

  @Builder
  createHeaderView() {
    Column(){
      Stack(){
        Image($r('app.media.mine_nav_bg'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)

        Row({
          space: 16
        }) {
          Image($r('app.media.avatar'))
            .width(64)
            .height(64)
            .borderRadius('50%')
            .border({
              color: $r('app.color.common_white_font'),
              width: 1.0
            })

          Column({
            space: 5
          }){
            Text('猫吃鱼')
              .fontSize(18)
              .fontColor($r('app.color.common_white_font'))
              .fontWeight(FontWeight.Medium)

            Row({
              space: 24
            }){
              Text('0关注')
                .headerTextStyle()

              Text('7粉丝')
                .headerTextStyle()

              Text('11获赞')
                .headerTextStyle()
            }
            .justifyContent(FlexAlign.Start)

            Row({
              space: 8
            }){
              Text('IP属地：辽宁')
                .headerTextStyle()

              Button('添加年龄、学校标签')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .fontColor($r('app.color.common_gray_font'))
                .height(24)
                .backgroundColor($r('app.color.common_white_background'))
            }
            .justifyContent(FlexAlign.Start)
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Start)
        }
        .padding(30)
        .width('100%')
        .height('100%')
        .opacity(this.opacityValue)
        .scale({
          y:this.opacityValue,
          x:this.opacityValue
        })
      }
    }
    .width('100%')
    .height(this.headerHeight)
  }

  @Builder
  createMenuView() {
    ListItem() {
      Column({
        space: 16
      }) {
        Row() {
          Text('我的功能')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Row({
            space: 3
          }) {
            Text('全部')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.common_gray_menu_font'))

            Image($r('app.media.left_arrow_gray'))
              .width(8)
              .height(16)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')

        Grid(){
          ForEach(this.menuItems, (item: MenuItem)=>{
            GridItem(){
              Column(){
                Image($r(`app.media.${item.icon}`))
                  .width(48)
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
              }
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsGap(16)
      }
      .padding({
        left:16,
        right:16
      })
    }
    .width('100%')
    .margin({
      top: 20
    })
  }

  @Builder
  createBannerView() {
    ListItem(){
      Row(){
        Row(){
          Column({
            space: 8
          }){
            Text('晒出你的兴趣爱好')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
            Text('发兴趣笔记分3万元现金奖励')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor($r('app.color.common_gray_font'))
          }
          .alignItems(HorizontalAlign.Start)

          Button('去领取')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor('#4A90E2')
            .borderRadius(4)
            .backgroundColor($r('app.color.common_white_background'))
            .padding({
              left: 10,
              right: 10,
              top: 4,
              bottom: 4
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#EFF6FF')
        .borderRadius(12)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .margin({
      top: 10
    })
  }

  @Builder
  createTabListView() {
    ListItemGroup({
      header: this.createTabListHeaderView()
    }){
      this.createListItem()
    }
    .width('100%')
  }

  @Builder
  createTabListHeaderView() {
    Grid(){
      ForEach(this.tabs, (item: MineTabItem, index)=>{
        GridItem(){
          Column({
            space: 10
          }){
            Text(item.title)
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(index === this.activeIndex ? '#4A90E2' : '#4B5563')
            Text()
              .backgroundColor('#4A90E2')
              .height(2)
              .width('100%')
              .visibility(index === this.activeIndex ? Visibility.Visible: Visibility.Hidden)
          }
          .onClick(() => {
            this.activeIndex = index
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr')
    .border({
      width: {
        top: 0,
        right: 0,
        bottom: 1,
        left: 0
      },
      color: '#E5E7EB'
    })
    .padding({
      top: 20
    })
    .backgroundColor($r('app.color.common_white_background'))
  }

  @Builder
  createListItem() {
    ListItem(){
      Column(){
        Column({
          space: 20
        }){
          Image($r('app.media.empty_icon'))
            .width(28)
            .height(40)

          Text('还没有作品，快去发布吧')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor('#6B7280')
        }
        .height(300)
        .justifyContent(FlexAlign.Center)
      }
      .height(1000)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
  }

  listDidScroll(){
    logger.info('Offset',`${this.scroller.currentOffset().yOffset}`)
    let offsetY = this.scroller.currentOffset().yOffset
    if (offsetY <= 0) {
      this.headerHeight = 144 - offsetY
      this.listTopOffset = offsetY
      this.opacityValue = 1
    } else if(offsetY > 0 && offsetY < 64){
      this.headerHeight = 144 - offsetY
      this.opacityValue = 1 - offsetY/64
    } else {
      this.headerHeight = 80
      this.listTopOffset = 0
      this.opacityValue = 0
    }
  }
}

@Extend(Text)
function headerTextStyle() {
  .fontSize(14)
  .fontColor($r('app.color.common_white_font'))
  .fontWeight(FontWeight.Regular)
}