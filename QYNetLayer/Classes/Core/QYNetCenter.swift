//
//  QYNetCenter.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/3.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public protocol QYNetCenterProtocol:NSObjectProtocol{
    
    func updateProgress(response:QYResponse)
    func completedHandler(respose:QYResponse)
    func errorHandler(error:ApiError)
}
public class QYNetCenter: NSObject {

    weak public var delegate:QYNetCenterProtocol?
    override public init() {
        super.init()
    }
    public func sendRequest(request:QYRequestProtocol) throws ->QYTask{   
        do {
            let megerPlug:QYMegerRequestPlug = QYMegerRequestPlug.init()
            megerPlug.setInputData(in:request)
            let rq = try megerPlug.getOutputData()
            let task:QYTask = try  QYBridgeNet.default.send(request: rq!,
                                                progress: self.progressHanlder,
                                                completed: self.completedHandler)
            return task
        } catch let error {
            throw error
        }
    }
    
    private  func progressHanlder(_ response:QYResponse)->Void{
        self.delegate?.updateProgress(response: response)
    }
    private func completedHandler(_ response:QYResponse)->Void{
        var rsp = response
        
        let serializerPlug:QYResposeSerializerPlug = QYResposeSerializerPlug.init()
        serializerPlug.setInputData(in: response)
        do {
            rsp.responseObj = try serializerPlug.getOutputData()
            self.delegate?.completedHandler(respose: rsp)
        } catch let error {
            self.delegate?.errorHandler(error: ApiError.DataSerialization(error))
        }
 
    }
}
