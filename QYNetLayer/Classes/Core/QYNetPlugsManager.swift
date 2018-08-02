//
//  QYNetPlugsManager.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/2.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import Foundation
/// TODO:LM 泛型协议不能作为类型 这里暂时用Any代替
public class QYNetPlugsManager:NSObject {
    public static var `default` = QYNetPlugsManager()
    private var plugs: Dictionary<QYPlugFuncType,Any> = Dictionary<QYPlugFuncType,Any>.init()
    private override init() {
        super.init()
        loadDefualtPlugs()
    }
    
    private func loadDefualtPlugs(){
        register(plug: QYUrlValidPlug.init(), forType: .megerRequest)
        register(plug: QYMegerRequestPlug.init(), forType: .megerRequest)
        register(plug: QYRequestConvertPlug.init(), forType: .convertRquest)
    }
    public func register(plug:Any,forType type:QYPlugFuncType) {
        self.plugs[type] = plug
    }
    public func remove(key:QYPlugFuncType){
        self.plugs.removeValue(forKey: key)
    }
    public func plug(key:QYPlugFuncType) -> Any? {
        return self.plugs[key]
    }
}
