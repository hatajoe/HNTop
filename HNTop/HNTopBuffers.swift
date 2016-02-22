//
//  HNTopBuffers.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/23/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import Foundation
import APIKit

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
        guard let l = object as? [Int] else {
            return nil
        }
        guard let d = HNTopResponse(IDList: l) else {
            return nil
        }
        return d
    }
}