import preferences from '@ohos.data.preferences';
import { AppSettings, ReadingSettings, DEFAULT_APP_SETTINGS, DEFAULT_READING_SETTINGS } from './Types';

/**
 * 存储管理工具类
 * 负责应用设置和阅读进度的持久化存储
 */
export class StorageManager {
  private static preferences: preferences.Preferences | null = null;
  private static readonly STORE_NAME = 'reader_app_preferences';
  
  // 键名常量
  private static readonly KEY_APP_SETTINGS = 'app_settings';
  private static readonly KEY_READING_SETTINGS = 'reading_settings';
  private static readonly KEY_READING_PROGRESS = 'reading_progress_';
  private static readonly KEY_FAVORITE_BOOKS = 'favorite_books';
  
  /**
   * 初始化存储
   */
  public static async initialize(): Promise<void> {
    if (!this.preferences) {
      this.preferences = await preferences.getPreferences(globalThis.context, this.STORE_NAME);
    }
  }
  
  /**
   * 保存应用设置
   * @param settings 应用设置
   */
  public static async saveAppSettings(settings: AppSettings): Promise<void> {
    await this.initialize();
    if (this.preferences) {
      await this.preferences.put(this.KEY_APP_SETTINGS, JSON.stringify(settings));
      await this.preferences.flush();
    }
  }
  
  /**
   * 读取应用设置
   * @returns 应用设置
   */
  public static async getAppSettings(): Promise<AppSettings> {
    await this.initialize();
    if (this.preferences) {
      const settingsJson = await this.preferences.get(this.KEY_APP_SETTINGS, JSON.stringify(DEFAULT_APP_SETTINGS));
      return JSON.parse(settingsJson as string);
    }
    return DEFAULT_APP_SETTINGS;
  }
  
  /**
   * 保存阅读设置
   * @param settings 阅读设置
   */
  public static async saveReadingSettings(settings: ReadingSettings): Promise<void> {
    await this.initialize();
    if (this.preferences) {
      await this.preferences.put(this.KEY_READING_SETTINGS, JSON.stringify(settings));
      await this.preferences.flush();
    }
  }
  
  /**
   * 读取阅读设置
   * @returns 阅读设置
   */
  public static async getReadingSettings(): Promise<ReadingSettings> {
    await this.initialize();
    if (this.preferences) {
      const settingsJson = await this.preferences.get(this.KEY_READING_SETTINGS, JSON.stringify(DEFAULT_READING_SETTINGS));
      return JSON.parse(settingsJson as string);
    }
    return DEFAULT_READING_SETTINGS;
  }
  
  /**
   * 保存阅读进度
   * @param bookId 书籍ID
   * @param progress 阅读进度（百分比）
   */
  public static async saveReadingProgress(bookId: number, progress: number): Promise<void> {
    await this.initialize();
    if (this.preferences) {
      const key = `${this.KEY_READING_PROGRESS}${bookId}`;
      await this.preferences.put(key, progress);
      await this.preferences.flush();
    }
  }
  
  /**
   * 读取阅读进度
   * @param bookId 书籍ID
   * @returns 阅读进度（百分比）
   */
  public static async getReadingProgress(bookId: number): Promise<number> {
    await this.initialize();
    if (this.preferences) {
      const key = `${this.KEY_READING_PROGRESS}${bookId}`;
      return await this.preferences.get(key, 0);
    }
    return 0;
  }
  
  /**
   * 保存收藏书籍列表
   * @param bookIds 收藏书籍ID列表
   */
  public static async saveFavoriteBooks(bookIds: number[]): Promise<void> {
    await this.initialize();
    if (this.preferences) {
      await this.preferences.put(this.KEY_FAVORITE_BOOKS, JSON.stringify(bookIds));
      await this.preferences.flush();
    }
  }
  
  /**
   * 获取收藏书籍列表
   * @returns 收藏书籍ID列表
   */
  public static async getFavoriteBooks(): Promise<number[]> {
    await this.initialize();
    if (this.preferences) {
      const booksJson = await this.preferences.get(this.KEY_FAVORITE_BOOKS, '[]');
      return JSON.parse(booksJson as string);
    }
    return [];
  }
  
  /**
   * 添加书籍到收藏
   * @param bookId 书籍ID
   */
  public static async addToFavorites(bookId: number): Promise<void> {
    const favorites = await this.getFavoriteBooks();
    if (!favorites.includes(bookId)) {
      favorites.push(bookId);
      await this.saveFavoriteBooks(favorites);
    }
  }
  
  /**
   * 从收藏中移除书籍
   * @param bookId 书籍ID
   */
  public static async removeFromFavorites(bookId: number): Promise<void> {
    const favorites = await this.getFavoriteBooks();
    const index = favorites.indexOf(bookId);
    if (index > -1) {
      favorites.splice(index, 1);
      await this.saveFavoriteBooks(favorites);
    }
  }
  
  /**
   * 检查书籍是否被收藏
   * @param bookId 书籍ID
   * @returns 是否被收藏
   */
  public static async isFavorite(bookId: number): Promise<boolean> {
    const favorites = await this.getFavoriteBooks();
    return favorites.includes(bookId);
  }
  
  /**
   * 清空所有存储
   */
  public static async clearAll(): Promise<void> {
    await this.initialize();
    if (this.preferences) {
      await this.preferences.clear();
      await this.preferences.flush();
    }
  }
}
