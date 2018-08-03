//
//  QYResposeSerializerPlug.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/3.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYResposeSerializerPlug: NSObject {
    private var inputData: QYResponse?
    public override init() {
        super.init()
    }
}

extension QYResposeSerializerPlug: QYPlugsProtocol {
    public typealias inputType = QYResponse

    public typealias outputType = Any

    public func setInputData(in data: QYResponse) {
        inputData = data
    }

    public func getOutputData() throws -> Any? {
        guard let response = self.inputData ,let request = response.reqeust else {
            throw ApiError.resposeEmptyData
        }
        do {
            switch request.resposeSerializerType {
            case .json:
                return try self.serializeResponseJSON(data: response.data)
            case .plist :
                return try self.serializeResponsePropertyList(data: response.data)
            case .raw:
                return try self.serializeResponseData(data: response.data)
            }
        } catch let error  {
            
            throw error
        }
    }
}

extension QYResposeSerializerPlug {

    private func serializeResponseData(data: Data?) throws -> Data {
        guard let validData = data else {
            throw ApiError.resposeEmptyData
        }
        return validData
    }

    private  func serializeResponseJSON(
        options: JSONSerialization.ReadingOptions = .mutableContainers,
        data: Data?) throws
        -> Any {
        guard let validData = data, validData.count > 0 else {
            throw ApiError.resposeEmptyData
        }
        do {
            let json = try JSONSerialization.jsonObject(with: validData, options: options)
            return json
        } catch let error {
            throw ApiError.DataSerialization(error)
        }
    }

    private  func serializeResponsePropertyList(
        options: PropertyListSerialization.ReadOptions = .mutableContainers,
        data: Data?) throws
        -> Any {
        guard let validData = data, validData.count > 0 else {
            throw ApiError.resposeEmptyData
        }

        do {
            let plist = try PropertyListSerialization.propertyList(from: validData, options: options, format: nil)
            return plist
        } catch {
            throw ApiError.DataSerialization(error)
        }
    }
}
