/**
 * 类型定义文件
 * API 20 版本 - 使用完整的类型系统
 */

/**
 * 书本信息接口
 */
export interface BookInfo {
  id: number
  title: string
  author: string
  cover: string
  category: string
  progress: number
}

/**
 * 阅读主题接口
 */
export interface ReaderTheme {
  bgColor: ResourceColor
  textColor: ResourceColor
  name: string
}

/**
 * 阅读设置接口
 */
export interface ReadingSettings {
  fontSize: number
  lineHeight: number
  wordSpacing: number
  isNightMode: boolean
}

/**
 * 目录项接口
 */
export interface TocItem {
  title: string
  progress: number
}

/**
 * 应用设置接口
 */
export interface AppSettings {
  themeMode: 'light' | 'dark'
  defaultFontSize: number
  nightMode: boolean
  soundEnabled: boolean
  autoSleepMinutes: number
}

/**
 * 书籍内容接口
 */
export interface BookContent {
  toc: TocItem[]
  content: string[]
}

/**
 * 路由参数接口
 */
export interface ReaderParams {
  bookId: number
}

/**
 * 预定义主题常量
 */
export const PREDEFINED_THEMES: Record<string, ReaderTheme> = {
  light: {
    bgColor: '#FFFFFF',
    textColor: '#333333',
    name: '亮色'
  },
  dark: {
    bgColor: '#1a1a1a',
    textColor: '#e0e0e0',
    name: '深色'
  },
  sepia: {
    bgColor: '#f4ecd8',
    textColor: '#5b4636',
    name: '护眼'
  },
  night: {
    bgColor: '#000000',
    textColor: '#888888',
    name: '夜间'
  }
}

/**
 * 默认阅读设置
 */
export const DEFAULT_READING_SETTINGS: ReadingSettings = {
  fontSize: 16,
  lineHeight: 24,
  wordSpacing: 4,
  isNightMode: false
}

/**
 * 默认应用设置
 */
export const DEFAULT_APP_SETTINGS: AppSettings = {
  themeMode: 'light',
  defaultFontSize: 16,
  nightMode: false,
  soundEnabled: true,
  autoSleepMinutes: 30
}
