//
//  HNResponse.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/23/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import Foundation

struct HNTopResponse {
    var IDList: [Int]
    init?(IDList: [Int]) {
        self.IDList = IDList
    }
}

protocol HNTopRequestType : RequestType {
    
}

extension HNTopRequestType {
    var baseURL:NSURL {
        return NSURL(string: "https://hacker-news.firebaseio.com")!
    }
}

struct HNTopRequest: HNTopRequestType {
    typealias Response = HNTopResponse
    
    var method: HTTPMethod {
        return .GET
    }
    
    var path: String {
        return "v0/topstories.json"
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        // 受信データを[String:AnyObject]のDictionary型にキャストする
        guard let l = object as? [Int] else {
            return nil
        }
        // Dictionaryを使用してWeather型のデータを初期化する
        guard let d = HNTopResponse(IDList: l) else {
            return nil
        }
        // 初期化したWeather型のデータを返す
        return d
    }
}