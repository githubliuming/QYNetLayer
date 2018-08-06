//
//  QYParamEcodingPlug.swift
//  QYNetLayer
//
//  Created by anita on 2018/8/4.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit
import Alamofire
public class QYParamEcodingPlug: NSObject {

      public typealias  ParameterEncoding = Alamofire.ParameterEncoding
      public typealias  URLEncoding = Alamofire.URLEncoding
      public typealias  JSONEncoding = Alamofire.JSONEncoding
      public typealias  ProertyListEncoding = Alamofire.PropertyListEncoding
      private var inputData:inputType?

      override public init() {
            super.init()
      }


}
extension QYParamEcodingPlug: QYPlugsProtocol{
      
      public typealias outputType = URLRequest

      public typealias inputType = (URLRequest,[String:Any],QYRequestSerializerType)

      public func setInputData(in data: (URLRequest, [String : Any],QYRequestSerializerType)) {

            self.inputData = data
      }
      public func getOutputData() throws -> URLRequest? {
            guard let data = self.inputData else {

                  throw ApiError.paramEncodingInputNil
            }
            do {
                  switch data.2 {
                  case .json:
                        return try self.serializer(encoder: JSONEncoding.default, request: data.0, params: data.1)
                  case .plist:
                        return try self.serializer(encoder: ProertyListEncoding.default, request: data.0, params: data.1)
                  case .raw:
                        return try self.serializer(encoder: URLEncoding.default, request: data.0, params: data.1)
                  }

            } catch let error {
                  throw ApiError.paramEncodingError(error)
            }
      }
}

extension QYParamEcodingPlug {

      private func serializer(encoder:ParameterEncoding,request:URLRequest,params:[String:Any]) throws ->URLRequest {

            do {
                 return try encoder.encode(request, with: params)
            } catch let error	 {

                  throw error
            }
      }
}
