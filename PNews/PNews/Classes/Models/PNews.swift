//
//  PNews.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsResponse: Mappable {
    
    var status: String?
    var articles = [Article]()
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        status <- map["status"]
        articles <- map["articles"]
    }
}

class Article: Mappable {
    
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var url: String?
    var urlToImage: String?
    var publishedDate: String?
    
    init(){}
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        content <- map["content"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedDate <- map["publishedAt"]
    }
}
