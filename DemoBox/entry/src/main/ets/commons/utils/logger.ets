import { hilog } from '@kit.PerformanceAnalysisKit';

class Logger {
  // 需求：封装 info debug warn error 日志方法
  // 减少 domain tag format 参数使用频率

  domain: number = 0xE000
  tag: string = 'DebugLog'
  format: string = '%{public}s, %{public}s'

  constructor(domain: number, tag: string) {
    this.domain = domain
    this.tag = tag
  }

  info(...args: string[]) {
    hilog.info(this.domain, this.tag, this.format, args)
  }

  debug(...args: string[]) {
    hilog.debug(this.domain, this.tag, this.format, args)
  }

  warn(...args: string[]) {
    hilog.warn(this.domain, this.tag, this.format, args)
  }

  error(...args: string[]) {
    hilog.error(this.domain, this.tag, this.format, args)
  }
}

const DOMAIN = 0xE000
const TAG = 'DebugLog'

export const logger = new Logger(DOMAIN, TAG);