import { HomePage } from '../pages/Home/HomePage'
import { FollowPage } from './Follow/FollowPage'
import { MinePage } from './Mine/MinePage'
import { VideoPage } from './Video/VideoPage'
import {fullScreen} from '../commons/utils/fullScreen'
import { LengthMetrics } from '@kit.ArkUI'

@Entry
@ComponentV2
struct Index {
  @Local activeIndex: number = 0
  @Provider() pageInfos: NavPathStack = new NavPathStack();
  private tabItems: TabItem[] = [
    {
      name: '首页',
      icon: $r('app.media.tab_home_default'),
      activeIcon: $r('app.media.tab_home_selected'),
      type: TabType.home
    },
    {
      name: '视频',
      icon: $r('app.media.tab_video_default'),
      activeIcon: $r('app.media.tab_video_selected'),
      type: TabType.video
    },
    {
      name: '关注',
      icon: $r('app.media.tab_follow_default'),
      activeIcon: $r('app.media.tab_follow_selected'),
      type: TabType.follow
    },
    {
      name: '我得',
      icon: $r('app.media.tab_mine_default'),
      activeIcon: $r('app.media.tab_mine_selected'),
      type: TabType.mine
    }
  ]

  build() {
    Column() {
      Navigation(this.pageInfos) {
        Tabs({
          barPosition: BarPosition.End,
          index: this.activeIndex
        }) {
          ForEach(this.tabItems, (item: TabItem, index) => {
            TabContent() {
              this.createTabChild(item)
            }
            .tabBar(this.TabItemBuilder(item, index))
          })
        }
        .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
        .scrollable(false)
        .onTabBarClick(i => {
          this.activeIndex = i
        })
        .safeAreaPadding({
          bottom: LengthMetrics.vp(fullScreen.bottomHeight)
        })
      }
      .mode(NavigationMode.Stack)
      .titleMode(NavigationTitleMode.Mini)
      .hideTitleBar(true)
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  createTabChild(item: TabItem) {
    if (item.type === TabType.home) {
      HomePage()
    } else if (item.type === TabType.video) {
      VideoPage()
    } else if (item.type === TabType.follow) {
      FollowPage()
    } else if (item.type === TabType.mine) {
      MinePage()
    }
  }

  @Builder
  TabItemBuilder(item: TabItem, i: number) {
    Column({ space: 4 }) {
      Image(this.activeIndex === i ? item.activeIcon : item.icon)
        .width(14)
        .height(11)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.activeIndex === i ? $r('app.color.tab_item_text_selected') :
          $r('app.color.tab_item_text_default'))
    }
  }
}

interface TabItem {
  name: string
  icon: Resource
  activeIcon: Resource
  type: TabType
}

enum TabType {
  home, video, follow, mine
}