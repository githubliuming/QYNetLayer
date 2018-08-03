//
//  QYRequstBuilder.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/2.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Foundation
public class QYRequestBuilder<T: QYRequestProtocol> {
    private var request: T = T(baseUrl: "")
    init() {
    }

    /// 接口路径
    public func apiPath(path: String?) -> QYRequestBuilder {
        request.apiPath = path
        return self
    }

    // 请求url
    public func url(url: String?) -> QYRequestBuilder {
        request.url = url
        return self
    }

    public func timeOutInterval(time: TimeInterval = 10) -> QYRequestBuilder {
        request.timeOutInterval = time
        return self
    }

    /// 是否忽略全局配置的 httpHeader 默认 false 不忽略
    public func ingoreGloableHeaders(isIngore: Bool = false) -> QYRequestBuilder {
        request.ingoreGloableHeaders = isIngore
        return self
    }

    /// 本次请求是否忽略默认配置的请求参数 默认为NO 不忽略
    public func ingoreGloableParams(isIngore: Bool = false) -> QYRequestBuilder {
        request.ingoreGloableParams = isIngore
        return self
    }

    /// 参数
    public func setParams(params: [String: Any]) -> QYRequestBuilder {
        request.params = params
        return self
    }

    /// 添加参数
    ///
    /// - Parameters:
    ///   - key: 参数名称
    ///   - value: 参数值
    /// - Returns: request构建器
    public func addParam(key: String, value: Any) -> QYRequestBuilder {
        if request.params.isEmpty {
            _ = setParams(params: Dictionary<String, Any>.init())
        }
        request.params[key] = value
        return self
    }

    /// 自定义头部
    public func setHeader(headers: [String: String]) -> QYRequestBuilder {
        request.headers = headers
        return self
    }
    
    /// 添加http请求头部信息
    ///
    /// - Parameters:
    ///   - key: 头部key
    ///   - value: 头部value
    /// - Returns: request构建器
    public func addHeader(key: String, value: String) -> QYRequestBuilder {
        if request.headers.isEmpty {
            _ = setHeader(headers: Dictionary<String, String>.init())
        }
        request.headers[key] = value
        return self
    }

    /// 混存策略
    public func cachPolicy(policy: URLRequest.CachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy) -> QYRequestBuilder {
        request.cachePolicy = policy
        return self
    }

    /// 消息ID
    public func msgId(msgId: Int) -> QYRequestBuilder {
        request.msgId = msgId
        return self
    }

    /// 消息tag
    public func tag(tag: Int) -> QYRequestBuilder {
        request.tag = tag
        return self
    }

    /// 请求类型
    public func requstType(type: QYRequestType = QYRequestType.normal) -> QYRequestBuilder {
        request.requstType = type
        return self
    }

    /// HttpMethod
    public func httpMethod(method: QYHttpMethod = .get) -> QYRequestBuilder {
        request.httpMethod = method
        return self
    }

    /// 是否支持断点续传 默认 true
    public func supportBreakpoint(isSupport: Bool = true) -> QYRequestBuilder {
        request.supportBreakpoint = isSupport
        return self
    }

    /// 重试次数 默认 3次
    public func retryCount(count: Int = 3) -> QYRequestBuilder {
        request.retryCount = count
        return self
    }

    /// 重试间隔 0.2s
    public func retryDelayTime(time: TimeInterval = 0.2) -> QYRequestBuilder {
        request.retryDelayTime = time
        return self
    }

    /// 是否允许重复请求
    public func allowRepeatRequest(allow: Bool = false) -> QYRequestBuilder {
        request.allowRepeatRequest = allow
        return self
    }

    /// 请求任务优先级
    public func taskPrority(priority: QYTaskPriority = .defualt) -> QYRequestBuilder {
        request.taskPrority = priority
        return self
    }

    public func resopseSerializerType(type:QYResopseSerializerType = .json) -> QYRequestBuilder {
        request.resposeSerializerType = type
        return self
    }
    public func getRequst() -> T {
        return request
    }
}
