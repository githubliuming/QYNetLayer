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

        let requst = HttpBuilder()
            .url(url: "http://www.baidu.com")
            .msgId(msgId: 3)
            .getRequst()

        api.startRuqest(request: requst)
        print(requst)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
