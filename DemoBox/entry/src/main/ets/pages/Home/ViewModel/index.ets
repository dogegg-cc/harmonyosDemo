import { http } from "../../../commons/utils/httpClient"
import { NewsModel, ImageModel } from "../Model/index"
import { tools } from "../../../commons/utils/tools"

@ObservedV2
export class HomePageListViewModel{
  channelType: string
  @Trace dataList: NewsModel[] = [] // 新闻列表
  @Trace swiperDataList: NewsModel[] = [] // 轮播图数据
  @Trace isRefreshing: boolean = false // 是否正在刷新
  @Trace isLoadMore: boolean = false // 是否正在加载更多
  @Trace isFirstLoading: boolean = true // 是否首次加载

  constructor(channelType: string) {
    this.channelType = channelType
  }

  // 下拉刷新
  async refreshData() {
    await Promise.all([
      this.loadNewsList(true),
      this.loadSwiperData()
    ])
  }

  // 加载更多
  async loadMoreData() {
    this.isLoadMore = true
    await this.loadNewsList(false)
    this.isLoadMore = false
  }

  // 列表数据根据刷新还是加载更多，添加数据
  async loadNewsList(isRefresh: boolean) {
    const data = await this.loadNewsData(isRefresh)
    this.isRefreshing = false
    this.isFirstLoading = false
    if (isRefresh) {
      this.dataList = data
    } else {
      this.dataList.push(...data)
    }
  }

  // 整体新闻列表数据请求
  async loadNewsData(isRefresh: boolean): Promise<NewsModel[]> {
    const timestamp = Math.floor(new Date().getTime() / 1000)
    const data = await http.ttRequest<NewsModel[]>({
      url:'/stream',
      params: {
        'category':this.channelType,
        'partner':'toutiao',
        'access_token':'wap',
        'timestamp': `${timestamp}`,
        'from':'h5',
        'allow_stick':isRefresh ? '1' : '0',
        'first_refresh':isRefresh ? '1' : '0',
        'allow_force_insert':isRefresh ? '1' : '0'
      },
      headers: {
        'Cookie':'tt_webid=7613303218035476019;utm_source=torchlight_preview_test'
      }
    })
    return data
  }

  // 请求轮播图数据，没有接口，只能再次请求列表接口，把有图片的新闻筛选出来
  async loadSwiperData() {
    const data = await this.loadNewsData(false)
    let list = data.filter((item) => {
      return item.cover_mode !== 0
    }).map((item)=>{
      if(item.cover_mode === 2) {
        item.middle_image = tools.getFirst<ImageModel>(item.image_list ?? [])
      }
      return item
    }).slice(0, 5)
    this.swiperDataList = list
  }
}