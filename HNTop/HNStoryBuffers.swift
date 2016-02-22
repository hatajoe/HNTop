//
//  HNStoryBuffers.swift
//  HNTop
//
//  Created by hatanakayusuke on 2/23/16.
//  Copyright © 2016 hatanakayusuke. All rights reserved.
//

import Foundation
import APIKit

struct HNStoryResponse {
    var ID: Int
    var Author: String
    var Score: Int
    var Time: Int
    var Title: String
    var Url: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let ID = dictionary["id"] as? Int else {
            return nil
        }
        guard let Author = dictionary["by"] as? String else {
            return nil
        }
        guard let Score = dictionary["score"] as? Int else {
            return nil
        }
        guard let Time = dictionary["time"] as? Int else {
            return nil
        }
        guard let Title = dictionary["title"] as? String else {
            return nil
        }
        guard let Url = dictionary["url"] as? String else {
            return nil
        }
        self.ID = ID
        self.Author = Author
        self.Score = Score
        self.Time = Time
        self.Title = Title
        self.Url = Url
    }
}

protocol HNStoryRequestType : RequestType {
    
}

extension HNStoryRequestType {
    var baseURL:NSURL {
        return NSURL(string: "https://hacker-news.firebaseio.com")!
    }
}

struct HNStoryRequest: HNStoryRequestType {
    typealias Response = HNStoryResponse
    
    var method: HTTPMethod {
        return .GET
    }
    
    var ID: Int
    var path: String {
        return "v0/item/\(self.ID).json"
    }
    
    init(ID: Int) {
        self.ID = ID
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let m = object as? [String: AnyObject] else {
            return nil
        }
        guard let d = HNStoryResponse(dictionary: m) else {
            return nil
        }
        return d
    }
}