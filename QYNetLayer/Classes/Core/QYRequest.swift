//
//  QYRequest.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYRequest: NSObject, QYRequestProtocol {
    /// 接口路径
    public var apiPath: String?

    ///  请求url，当url有值且全局配置的BaseUrl也有值 并且ingoreBaseUrl为NO的情况下以全局配置的url为准
    public var url: String?

    /// 接口完整路径 baseUrl + api
    public var fullUrl: String?

    /// 完整的请求Url baseUrl + api + params
    public var uriPath: String?
    /// 超时时间
    public var timeOutInterval: TimeInterval = 10.0
    /// 是否忽略全局配置的 httpHeader 默认 false 不忽略
    public var ingoreGloableHeaders: Bool = false
    /// 本次请求是否忽略默认配置的请求参数 默认为NO 不忽略
    public var ingoreGloableParams: Bool = false
    /// 文件路径
    public var fileUrl: String?
    /// 参数
    public var params: Dictionary<String, Any> = Dictionary<String, Any>.init()
    /// 自定义头部
    public var headers: Dictionary<String, String> = Dictionary<String,String>.init()
    /// 混存策略
    public var cachePolicy: URLRequest.CachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
    /// 消息ID
    public var msgId: Int = 0
    /// 消息tag
    public var tag: Int = 0
    /// 请求类型
    public var requstType: QYRequestType = .normal
    /// HttpMethod
    public var httpMethod: QYHttpMethod = .get
    /// 是否支持断点续传 默认 true
    public var supportBreakpoint: Bool = true
    /// 重试次数 默认 3次
    public var retryCount: Int = 3
    /// 重试间隔 0.2s
    public var retryDelayTime: TimeInterval = 0.2
    /// 是否允许重复请求
    public var allowRepeatRequest: Bool = false
    /// 请求任务优先级
    public var taskPrority: QYTaskPriority = .defualt
    /// 返回数据序列化格式
    public var resposeSerializerType: QYResopseSerializerType = .json
    public required init(baseUrl url: String?) {
        self.url = url
        super.init()
    }

    public required convenience init(apiPath path: String?) {
        self.init(baseUrl: nil)
        apiPath = path
    }
}
