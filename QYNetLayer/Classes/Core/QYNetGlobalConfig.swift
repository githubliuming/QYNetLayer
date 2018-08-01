//
//  QYNetGloabalConfig.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

class QYNetGlobalConfig: NSObject {

    public static var `default` = QYNetGlobalConfig.init()
    
    /// baseUrl
    public var baseUrl:String = String.init()
    
    /// 是否开启log输出
    public var consoleLog:Bool = true;
    
    /// 回调队里
    public var callBackQueue:DispatchQueue = DispatchQueue.main
    
    /// 全局参数
    public var globalParams:Dictionary<String,Any> = Dictionary<String,Any>.init()
    
    /// 全局 httpHeader
    public var globalHeaders:Dictionary<String,Any> = Dictionary<String,Any>.init()
    
    ///最大并发数
    public var maxConcurrentOperationCount:Int = 10
    override private init() {
        super.init()
    }
}
