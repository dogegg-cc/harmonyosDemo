
export class tools {
  static getFirst<T>(array: T[]): T | undefined {
    return array.length > 0 ? array[0] : undefined;
  }

  static formatTime(timestamp: number): string {
    timestamp = timestamp * 1000
    const now = Date.now();
    const diff = now - timestamp;

    if (diff < 60000) {
      return '刚刚';
    } else if (diff < 3600000) {
      return `${Math.floor(diff / 60000)}分钟前`;
    } else if (diff < 43200000) {
      return `${Math.floor(diff / 3600000)}小时前`;
    } else {
      const date = new Date(timestamp);
      return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    }
  }

  static formatNumber(num: number): string {
    if (num < 1000) {
      return num.toString();
    } else if (num < 10000) {
      return `${Math.floor(num / 1000)}千`;
    } else {
      return `${Math.floor(num / 10000)}万`;
    }
  }
}
