  import { AppStorageV2, window} from '@kit.ArkUI'

import {
  common
} from '@kit.AbilityKit';
  import { logger } from './logger';

  @ObservedV2
class FullScreen {
  @Trace topHeight: number = 0
  @Trace bottomHeight: number = 0

  context ?: common.UIAbilityContext
  async enable() {
    if (this.context) {
      try {
        const win = await window.getLastWindow(this.context)
        const ui = this.context.windowStage.getMainWindowSync().getUIContext()
        win.setWindowLayoutFullScreen(true)
        // 共享安全区高度
        const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect
        const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect
        fullScreen.topHeight = ui.px2vp(topArea.height)
        fullScreen.bottomHeight = ui.px2vp(bottomArea.height)
      } catch (e) {

      }
    }
  }

    // 需求：提供 setBar setDarkBar setLightBar
    async setBar(properties: window.SystemBarProperties) {
      try {
        if (this.context) {
          const win = await window.getLastWindow(this.context)
          await win.setWindowSystemBarProperties(properties)
        }
      } catch (e) {
        logger.error('StatusBar setBar', JSON.stringify(e))
      }

    }

    setDarkBar() {
      this.setBar({ statusBarContentColor: '#000000' })
    }

    setLightBar() {
      this.setBar({ statusBarContentColor: '#ffffff' })
    }
}
export const fullScreen = new FullScreen()