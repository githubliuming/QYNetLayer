//
//  QYUrlValidPlug.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

class QYUrlValidPlug: NSObject, QYPlugsProtocol {
    public typealias inputType = String

    public typealias outputType = Bool
    private var url: String = ""
    override init() {
        super.init()
    }

    func setInputData(in data: String) {
        url = data
    }
    @discardableResult
    func getOutputData() throws -> Bool? {
        
        if self.url.isEmpty {
            return false
        }
        do {
            let result:Bool = try verifyUrl(str: self.url)
            return result
        } catch let error {
            throw ApiError.urlValidError(error: error)
        }
    }

    /// 验证URL格式是否正确
    private func verifyUrl(str: String) throws -> Bool {
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str,
                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                           range: NSMakeRange(0, str.count))
            // 判断结果(完全匹配)
            if res.count == 1 && res[0].range.location == 0
                && res[0].range.length == str.count {
                return true
            }
        } catch {
           throw error
        }
        return false
    }
}
