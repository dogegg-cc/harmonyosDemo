import { fullScreen } from "../../commons/utils/fullScreen"
import { LengthMetrics } from "@kit.ArkUI"
import { webview } from "@kit.ArkWeb"

@Builder
export function WebPageBuilder(name: string, src: string) {
  WebPage({
    src: src
  })
}

@ComponentV2
export struct WebPage {
  @Require @Param src: string
  webController = new webview.WebviewController()
  build() {
    NavDestination(){
      Web({
        src: this.src,
        controller: this.webController
      })
        .width('100%')
        .layoutWeight(1)
    }
    .safeAreaPadding({
      top: LengthMetrics.vp(fullScreen.topHeight)
    })
  }
}