import axios, { AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { logger } from './logger'

const service = axios.create({
  baseURL: 'https://m1.apifoxmock.com/m1/7679452-7421578-default',
  timeout: 10000
})

service.interceptors.response.use((res: AxiosResponse)=>{
  if (res.data.code === 1) {
    logger.info('网络请求成功:',JSON.stringify(res.data.data))
    return res.data.data
  }
  return Promise.reject(res.data)
}, (err: AxiosError)=>{
  logger.info('ERROR:', JSON.stringify(err))
  return Promise.reject(err)
})

const serviceTT = axios.create({
  baseURL: 'https://open.toutiao.com/content',
  timeout: 10000
})

serviceTT.interceptors.response.use((res: AxiosResponse)=>{
  if (res.data.ret === 0) {
    logger.info('网络请求成功:', JSON.stringify(res.data.data))
    return res.data.data
  }
  return Promise.reject(res.data)
}, (err: AxiosError)=>{
  logger.info('Response ERROR:', JSON.stringify(err))
  return Promise.reject(err)
})

serviceTT.interceptors.request.use((req: InternalAxiosRequestConfig)=>{
  logger.info('Request Data:', JSON.stringify(req))
  return req
}, (err: AxiosError)=>{
  logger.info('Request ERROR:', JSON.stringify(err))
  return Promise.reject(err)
})

class HttpClient {
  // 需求：响应数据类型+请求参数类型
  request<Res, Req = Object>(config: AxiosRequestConfig<Req>) {
    return service<null, Res, Req>(config)
  }

  ttRequest<Res, Req = Object>(config: AxiosRequestConfig<Req>) {
    return serviceTT<null, Res, Req>(config)
  }
}

export const http = new HttpClient()
