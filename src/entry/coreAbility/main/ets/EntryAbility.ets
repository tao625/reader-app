import { UIAbility } from '@kit.AbilityKit'
import { window } from '@kit.ArkInterface'

/**
 * 应用入口 Ability
 * 负责应用的启动、生命周期管理
 */
export default class EntryAbility extends UIAbility {
  /**
   * 窗口创建回调
   * @param windowId 窗口 ID
   */
  override async onWindowStageCreate(windowId: string) {
    // 设置启动页面为书本列表页
    const windowStage = window.getWindow(windowId)
    await windowStage.loadContent('pages/Index')

    // 设置应用窗口属性
    windowStage.takeSurface(windowId)
  }

  /**
   * 应用启动回调
   */
  override async onStartWant(want: Want) {
    console.info('App started')
  }

  /**
   * 应用进入前台
   */
  override async onForeground() {
    console.info('App came to foreground')
  }

  /**
   * 应用进入后台
   */
  override async onBackground() {
    console.info('App went to background')
  }

  /**
   * 应用关闭
   */
  override async onDestroy() {
    console.info('App destroyed')
  }
}
