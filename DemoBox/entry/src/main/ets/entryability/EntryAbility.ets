import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { AppStorageV2, UIContext, window } from '@kit.ArkUI';
import {fullScreen} from '../commons/utils/fullScreen'
import { logger } from '../commons/utils/logger'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      logger.error('Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    logger.info('Ability onCreate')
    fullScreen.context = this.context
  }

  onDestroy(): void {
    logger.info('Ability onDestroy')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    logger.info('Ability onWindowStageCreate')
    fullScreen.enable()
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        logger.error('Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      logger.info('Succeeded in loading the content.')
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    logger.info('Ability onWindowStageDestroy')
  }

  onForeground(): void {
    // Ability has brought to foreground
    logger.info('Ability onForeground')
  }

  onBackground(): void {
    // Ability has back to background
    logger.info('Ability onBackground')
  }
}