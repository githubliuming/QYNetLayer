//
//  QYMegerRequestPlug.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

public class QYMegerRequestPlug: NSObject,QYPlugsProtocol {
    
    public typealias inputType = QYRequestProtocol
    
    public typealias outputType = QYRequestProtocol
    
    private var inputData:inputType?;
    
    public func setInputData(in data: inputType) {
       
        self.inputData = data
         
    }
    
    public func getOutputData() throws -> outputType?{
        
        return self.inputData ;
    }
    
    public override init() {
        super.init()
    }
}
