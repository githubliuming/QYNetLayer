//
//  QYReustConvertPlug.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/2.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYRequestConvertPlug: NSObject,QYPlugsProtocol {
    
    
    public typealias inputType = QYRequestProtocol
    public typealias outputType = URLRequest
    
    private var inputData:QYRequestProtocol?
    public func setInputData(in data: QYRequestProtocol) {
        self.inputData = data;
    }
    
    public func getOutputData() throws -> URLRequest? {
        do {
            let urlRequest:URLRequest? = try convertRequest()
            return urlRequest
        } catch let error {
            throw error
        }
    }
    
    private func convertRequest() throws -> URLRequest?{

        guard let data = inputData else {
            throw ApiError.APIRequestNilError;
        }
        let url:URL? = URL.init(string: data.url!)
        guard let u = url else {
           throw ApiError.urlNileError(msgId: data.msgId)
        }
        
        var urlRquest = URLRequest.init(url: u, cachePolicy: data.cachePolicy, timeoutInterval: data.timeOutInterval);
        data.headers.forEach {urlRquest.setValue($0.value, forHTTPHeaderField: $0.key)}
        return urlRquest
    }
    
}
