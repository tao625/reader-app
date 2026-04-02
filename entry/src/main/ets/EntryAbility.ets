import { UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'
import { hilog } from '@kit.PerformanceAnalysisKit'

/**
 * 应用入口 Ability
 * 负责应用的启动、生命周期管理
 * API 20 版本
 */
@Entry
export default class EntryAbility extends UIAbility {
  private windowStage_: window.WindowStage | null = null

  /**
   * 应用启动回调
   * @param want 启动参数
   * @param launchParam 启动参数
   */
  override onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onCreate')
  }

  /**
   * 窗口创建回调
   * @param windowStage 窗口阶段对象
   */
  override onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onWindowStageCreate')

    this.windowStage_ = windowStage

    // 设置启动页面为书本列表页
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'EntryAbility', `Failed to load content. Code: ${err.code}, message: ${err.message}`)
        return
      }
      hilog.info(0x0000, 'EntryAbility', 'Succeeded in loading content.')
    })
  }

  /**
   * 窗口销毁回调
   * @param windowStage 窗口阶段对象
   */
  override onWindowStageDestroy(): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onWindowStageDestroy')
  }

  /**
   * 窗口获得/失去焦点回调
   * @param hasFocus 是否有焦点
   */
  override onWindowStageFocus(hasFocus: boolean): void {
    hilog.info(0x0000, 'EntryAbility', `Ability onWindowStageFocus: ${hasFocus}`)
  }

  /**
   * 应用进入前台
   */
  override onForeground(): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onForeground')
  }

  /**
   * 应用进入后台
   */
  override onBackground(): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onBackground')
  }

  /**
   * 应用销毁
   */
  override onDestroy(): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onDestroy')
  }

  /**
   * 继续回调
   * @param want 继续参数
   */
  override onContinue(want: Want): void {
    hilog.info(0x0000, 'EntryAbility', 'Ability onContinue')
  }
}
