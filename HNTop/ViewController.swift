//
//  ViewController.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/23/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!;
    var detailItem: ListData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let data:ListData = self.detailItem {
            let requestURL = NSURL(string: data.Url)
            let req = NSURLRequest(URL: requestURL!)
            self.webView.loadRequest(req)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 読み込み開始時に呼ばれる
    func webViewDidStartLoad(webView: UIWebView) {
        // ステータスバーのインジケーターを表示
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    // 読み込み完了時に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        // インジケータを非表示にする
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

