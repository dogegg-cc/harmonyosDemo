
interface ChannelItem{
  title: string
  type: string
}

interface HomeChannelData{
  channelList: ChannelItem[]
}

interface NewsModel{
  abstract ?: string //简介
  publish_time ?: number // 发布日期
  cover_mode : number // 1: 大图，3：右小图，0：无图，2：三图
  title ?: string
  image_list ?: ImageModel[] // 图片
  middle_image ?: ImageModel //大图类型时使用
  source ?: string // 文章来源
  article_read_count ?: number // 阅读数
  item_id: number
  article_class ?: string // 文章类型
  article_url: string // 文章地址
}

interface ImageModel {
  url: string
  height: number
  width: number
}

export {ChannelItem, HomeChannelData, NewsModel, ImageModel}