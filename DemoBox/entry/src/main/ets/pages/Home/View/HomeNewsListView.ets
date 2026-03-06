import { NewsModel, ImageModel } from "../Model/index"
import { LengthMetrics } from "@kit.ArkUI"
import { tools } from "../../../commons/utils/tools"
import { Skeleton } from "../../../commons/components/Skeleton"
import { SkeletonOneImageItem, SkeletonTextItem } from "../../../commons/components/SkeletonItem"
import { HomePageListViewModel } from "../ViewModel"

@Preview
@ComponentV2
export struct HomeNewsListView {
  @Require @Param channelType: string
  viewModel: HomePageListViewModel = new HomePageListViewModel(this.channelType)
  @Consumer() pageInfos : NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    this.viewModel.refreshData()
  }

  build() {
    if (this.viewModel.isFirstLoading) {
      this.skeletonBuilder()
    } else {
      Refresh({
        refreshing: $$this.viewModel.isRefreshing
      }) {
        this.createListView()
      }
      .backgroundColor($r('app.color.common_gray_background'))
      .onRefreshing(() => {
        this.viewModel.refreshData()
      })
    }
  }

  @Builder
  createListView() {
    List({
      space: 16
    }){
      // 根据数据判断是否创建轮播图
      if (this.viewModel.swiperDataList.length > 0) {
        ListItem() {
          this.createSwiperView()
        }
      }
      // 分析 cell 类型，创建对应 cell
      this.createAllCells()
      // 加载更多
      this.loadMoreBuilder()
    }
    .height('100%')
    .width('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .padding({
      left: 16,
      right: 16,
      top: 16
    })
    .onReachEnd(() => {
      if (this.viewModel.isLoadMore || this.viewModel.isRefreshing) {
        return
      }
      this.viewModel.loadMoreData()
    })
  }

  @Builder
  createAllCells() {
    ForEach(this.viewModel.dataList, (item: NewsModel)=>{
      ListItem() {
        // 1: 大图，3：右小图，0：无图，2：三图
        if (item.cover_mode === 1) {
          this.createBigImageCell(item)
        } else if(item.cover_mode === 3) {
          this.createOneImageCell(item)
        } else if(item.cover_mode === 2) {
          this.createThreeImageCell(item)
        } else {
          this.createTextCell(item)
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor($r('app.color.common_white_background'))
      .borderRadius(12)
      .onClick(()=>{
        this.pageInfos.pushPathByName('WebPage',item.article_url)
      })
    }, (item: NewsModel) => {
      return `${item.item_id}`
    })
  }

  @Builder
  createBigImageCell(item: NewsModel) {
    Column({
      space: 12
    }){
      if(item.middle_image?.url){
        Image( item.middle_image?.url)
          .width('100%')
          .aspectRatio(1.6)
          .newsPostStyle()
      }

      Text(item.title)
        .newsTitleStyle()

      if (item.abstract) {
        Text(item.abstract)
          .newsAbstractStyle()
      }
      this.createSource(item)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  createSource(item: NewsModel) {
    Flex({
      justifyContent: FlexAlign.Start,
      space: {
        main: LengthMetrics.vp(8)
      }
    }){
      if (item.source){
        Text(item.source)
          .newsSourceStyle()
      }

      if (item.article_read_count){
        Text(tools.formatNumber(item.article_read_count)+ "人阅读")
          .newsSourceStyle()
      }

      if (item.publish_time){
        Text(tools.formatTime(item.publish_time))
          .newsSourceStyle()
      }
    }
  }

  @Builder
  createTextCell(item: NewsModel) {
    Column({
      space: 12
    }){

      Text(item.title)
        .newsTitleStyle()

      if (item.abstract) {
        Text(item.abstract)
          .newsAbstractStyle(3)
      }
      this.createSource(item)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  createOneImageCell(item: NewsModel) {
    Row({
      space: 16
    }){
      if(item.middle_image?.url){
        Image(item.middle_image?.url)
          .width(96)
          .aspectRatio(1)
          .newsPostStyle()
      }
      Column({
        space: 12
      }){
        Text(item.title)
          .newsTitleStyle()
        this.createSource(item)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
      .height(96)
      .layoutWeight(1)
    }
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  createThreeImageCell(item: NewsModel) {
    Column({
      space: 12
    }){
      Text(item.title)
        .newsTitleStyle()

      Row({
        space: 8
      }) {
        ForEach(item.image_list?.slice(0, 3) ?? [], (img: ImageModel)=>{
          Image(img.url)
            .width(96)
            .aspectRatio(1)
            .newsPostStyle()
        })
      }
      .justifyContent(FlexAlign.Start)

      this.createSource(item)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  loadMoreBuilder() {
    ListItem() {
      if (this.viewModel.isLoadMore) {
        Row({ space: 4 }) {
          LoadingProgress()
            .width(20)
          Text('正在加载...')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_font'))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height(80)
  }

  @Builder
  skeletonBuilder () {
    Skeleton(){
      Column({
        space: 12
      }){
        SkeletonTextItem()
        SkeletonOneImageItem()
        SkeletonTextItem()
        SkeletonOneImageItem()
        SkeletonTextItem()
        SkeletonOneImageItem()
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .padding(16)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.common_gray_background'))
    }
  }

  @Builder
  createSwiperView() {
    Swiper(){
      ForEach(this.viewModel.swiperDataList, (item: NewsModel) =>{
        this.createSwiperChildView(item)
      })
    }
    .borderRadius(12)
    .clip(true)
    .loop(true)
    .autoPlay(true)
    .interval(5000)
    .indicator(
      Indicator.dot()
        .itemWidth(5)
        .itemHeight(5)
        .selectedItemWidth(10)
        .selectedItemHeight(5)
        .color(Color.Gray)
        .selectedColor(Color.White)
    )
  }

  @Builder
  createSwiperChildView(item: NewsModel) {
    Stack() {
      Image(item.middle_image?.url)
        .newsPostStyle()

      Row()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['rgba(0,0,0,0.8)',0.0],['rgba(0,0,0,0.1)',0.4],['rgba(0,0,0,0.1)',0.6],['rgba(0,0,0,0.8)',1]]
        })

      Column() {
        Text(item.title)
          .fontColor($r('app.color.common_white_font'))
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .lineSpacing(LengthMetrics.vp(10))
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Flex({
          justifyContent: FlexAlign.Start,
          space: {
            main: LengthMetrics.vp(3)
          }
        }){
          if (item.source){
            Text(item.source)
              .newsSwiperSourceStyle()
          }

          if (item.article_class && item.source) {
            Text("•")
              .newsSwiperSourceStyle()
          }

          if (item.article_class){
            Text(item.article_class)
              .newsSwiperSourceStyle()
          }
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .padding({
        bottom: 30,
        top: 16,
        right: 16,
        left: 16
      })
    }
    .width('100%')
    .aspectRatio(1.87)
    .onClick(()=>{
      this.pageInfos.pushPathByName('WebPage',item.article_url)
    })
  }
}

@Extend(Text)// 新闻标题
function newsTitleStyle() {
  .fontColor($r('app.color.common_black_font'))
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
  .lineSpacing(LengthMetrics.vp(10))
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
}

@Extend(Text) // 新闻概述
function newsAbstractStyle(maxLines: number = 2) {
  .fontColor($r('app.color.common_gray_font'))
  .fontSize(14)
  .fontWeight(FontWeight.Regular)
  .lineSpacing(LengthMetrics.vp(6))
  .maxLines(maxLines)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
}

@Extend(Text) // 新闻来源
function newsSourceStyle() {
  .fontColor($r('app.color.common_gray_font'))
  .fontSize(12)
  .fontWeight(FontWeight.Regular)
}

@Extend(Image) // 新闻图片
function newsPostStyle() {
  .alt($r('app.media.image_placeholder'))
  .objectFit(ImageFit.Cover)
  .borderRadius(12)
}

@Extend(Text) // 新闻轮播图来源
function newsSwiperSourceStyle() {
  .fontColor($r('app.color.common_white_font'))
  .fontSize(12)
  .fontWeight(FontWeight.Regular)
}
