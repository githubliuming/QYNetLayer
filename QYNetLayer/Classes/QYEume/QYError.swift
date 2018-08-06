//
//  QYError.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Foundation

public enum ApiError:Swift.Error {
    case None
    case urlValidError(error:Swift.Error)
    case APIRequestNilError
    case urlRequestInitError(error:Swift.Error)
    case urlNilError(msgId:Int)
    case httpResonseError(error:Swift.Error?)
    case dataDecoderError(Swift.Error)
    case DataSerialization(Swift.Error)
    case resposeEmptyData
    case paramEncodingInputNil
    case paramEncodingError(Swift.Error)
    
    public var localizedDescription:String? {
        switch self {
        case .None:
            return ""
        case .urlValidError(let error):
            print(error)
            return error.localizedDescription
        case.APIRequestNilError:
            return "request is nil"
        case .urlNilError(let msgId):
            return "msgId = \(msgId)  request is nil"
        case .httpResonseError(let error):
            print(error ?? "")
            return error?.localizedDescription
        case .dataDecoderError(let error):
            print(error)
            return error.localizedDescription
        case .DataSerialization(let error):
            print(error)
            return error.localizedDescription
        case .resposeEmptyData:
            return "服务器返回数据为空"
        default:
            print(self)
            return "未定义error"
        }
    }
}

public enum QYRequestType: Int {
    case normal = 0
    case upload = 1
    case download = 2
}

public enum QYHttpMethod: String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

public enum QYTaskPriority:Int{
    case low = 0
    case defualt = 1
    case high = 2
}
public enum QYResopseSerializerType {
    case raw     //原始数据
    case json    //序列化成json
    case plist   //序列化成plist
}

public enum QYRequestSerializerType {

      case raw   // application/x-www-form-urlencoded
      case json  // application/json
      case plist // application/x-plist
}
public enum QYPlugFuncType:String{
    
    case validUrl = "validUrl"             //url验证
    case megerRequest =  "megerRequest"    //将request中http请求头、参数和全局配置中的http请求头、参数合并
    case convertRquest = "convertRquest"   //将QYRequestProtocol对象转换成 URLRequest插件
}

