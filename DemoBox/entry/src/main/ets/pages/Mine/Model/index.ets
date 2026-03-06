interface MenuItem {
  icon: string
  title: string
}

const MOCK_MENUITEM: MenuItem[] = [
  {
    icon: 'mine_menu_message',
    title: '消息私信'
  },
  {
    icon: 'mine_menu_history',
    title: '浏览历史'
  },
  {
    icon: 'mine_menu_idea',
    title: '创作中心'
  },
  {
    icon: 'mine_menu_playground',
    title: '活动广场'
  },
  {
    icon: 'mine_menu_order',
    title: '我的订单'
  },
  {
    icon: 'mine_menu_shopping',
    title: '购物车'
  },
  {
    icon: 'mine_menu_benefits',
    title: '购物福利'
  },
  {
    icon: 'mine_menu_customer_service',
    title: '退款/售后'
  }
]

interface MineTabItem {
  title: string,
  type: string
}

const MOCK_MINE_TAB_ITEMS: MineTabItem[] =[
  {
    title: '作品',
    type:'__all__'
  },
  {
    title: '收藏',
    type:'news_hot'
  },
  {
    title: '赞过',
    type:'news_tech'
  }
]

export {MenuItem, MOCK_MENUITEM, MOCK_MINE_TAB_ITEMS, MineTabItem}