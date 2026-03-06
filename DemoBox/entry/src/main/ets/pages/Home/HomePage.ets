import { Log } from "@abner/log"
import { fullScreen } from "../../commons/utils/fullScreen"
import { http } from "../../commons/utils/httpClient"
import { ChannelItem, HomeChannelData } from "./Model/index"
import { HomeNewsListView } from './View/HomeNewsListView'

@Preview
@ComponentV2
export struct HomePage {
  @Local channelList: ChannelItem[] = []
  @Local activeIndex: number = 0

  aboutToAppear(): void {
    this.loadChannelData()
  }

  build() {
    Column() {
      this.createNavBar()
      this.createItemChannel()
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  createNavBar() {
    Row() {
      Image($r('app.media.home_nav_logo'))
        .size({
          width: 76,
          height: 30
        })
      Image($r('app.media.home_nav_search'))
        .size({
          width: 16,
          height: 16
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({
      left: 16,
      right: 16
    })
    .height(30)
    .margin({
      top: fullScreen.topHeight
    })
  }

  @Builder
  createItemChannel() {
    Tabs({
      index: this.activeIndex,
      barPosition: BarPosition.Start
    }) {
      ForEach(this.channelList, (item: ChannelItem, index) => {
        TabContent() {
          HomeNewsListView({channelType: item.type})
        }
        .tabBar(this.createItemBar(item, index))
      })
    }
    .width('100%')
    .divider(
      {
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border')
      })
    .barMode(BarMode.Scrollable,{
      nonScrollableLayoutStyle: LayoutStyle.ALWAYS_AVERAGE_SPLIT
    })
    .barHeight(38)
    .align(Alignment.Start)
    .onSelected(i => {
      this.activeIndex = i
    })
    .layoutWeight(1)
  }

  @Builder
  createItemBar(item: ChannelItem, index: number) {
    Text(item.title)
      .fontSize(index === this.activeIndex ? 16 : 14)
      .fontWeight(FontWeight.Medium)
      .fontColor(index === this.activeIndex ? $r('app.color.tab_item_text_selected') :
        $r('app.color.tab_item_text_default'))
      .padding({
        left: index === 0 ? 16 : 0,
        right: 24
      })
  }

  async loadChannelData() {
    const data = await http.request<HomeChannelData>({
      url:'/news/getHomeChannelItem'
    })
    this.channelList = data.channelList
  }
}