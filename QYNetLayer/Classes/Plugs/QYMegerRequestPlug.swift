//
//  QYMegerRequestPlug.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYMegerRequestPlug: NSObject, QYPlugsProtocol {
    public typealias inputType = QYRequestProtocol

    public typealias outputType = QYRequestProtocol

    private var inputData: inputType?

    public override init() {
        super.init()
    }

    public func setInputData(in data: inputType) {
        inputData = data
    }

    public func getOutputData() throws -> QYRequestProtocol? {
        guard let data = self.inputData else {
            throw ApiError.APIRequestNilError
        }
        // 1、验证url
        let config: QYNetGlobalConfig = QYNetGlobalConfig.default
        let urlString = inputData?.url ?? config.baseUrl
        do {
            let validPlug: QYUrlValidPlug = QYUrlValidPlug()
            validPlug.setInputData(in: urlString)
            
            let result = try validPlug.getOutputData()
            if result == false {
                throw ApiError.urlNilError(msgId:data.msgId)
            }
            inputData?.url = urlString + (data.apiPath ?? "")
            //2、合并参数和http请求头
            if !data.ingoreGloableParams {
                inputData?.params = meger(from: data.params, to: config.globalParams)
            }
            if !data.ingoreGloableHeaders {
                inputData?.headers = meger(from: data.headers, to: config.globalHeaders) as! Dictionary<String, String>
            }
            if data.httpMethod == .get {
                  inputData?.requestSerializerType = .raw
            }
            return inputData

        } catch let error {
            throw error
        }
    }

   private func meger(from dic1: Dictionary<String, Any>, to dic2: Dictionary<String, Any>) -> Dictionary<String, Any> {
        var resultDic: Dictionary<String, Any> = dic2
        dic1.forEach { resultDic[$0.key] = $0.value }
        return resultDic
    }
}
