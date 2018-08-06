//
//  ViewController.swift
//  QYNetLayer
//
//  Created by liuming on 2018/8/1.
//  Copyright © 2018年 yoyo. All rights reserved.
//

import UIKit

typealias HttpBuilder = QYRequestBuilder<QYRequest>
typealias ApiManager = QYAPIManager
class ViewController: UIViewController {
    private let api: ApiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        api.delegate = self
        let requst = HttpBuilder()
            .url(url: "https://httpbin.org")
            .apiPath(path: "/get")
            .addParam(key: "mehtod", value: "post")
            .msgId(msgId: 3)
            .getRequst()

        api.startRuqest(requst)
        print(requst)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController:QYHttpDelegate{
    
    func httpRequestFailure(error: ApiError) {
        
        print("error .....\(error.localizedDescription ?? "")")
    }
    func httpRequestProgress(response: QYResponseProtocol) {
        let progress = response.progress?.fractionCompleted
        print("加载进度 = " + "\(progress ?? 0.0)")
    }
    func httpRequestSuccess(response: QYResponseProtocol) {
        print((response.responseObj as AnyObject).debugDescription)
    }
}
