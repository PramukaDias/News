//
//  PNewsAPI.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

// MARK: Service

class PNewsAPI: NSObject {
    
    class func getNews(viewType: NewsViewType, keyword: String, onSuccess: @escaping (_ newsArray : [Article]) -> Void, onError: @escaping (String) -> Void) {
        let url = self.getNewsUrl(viewType: viewType, keyword: keyword)
        Alamofire.request(url).responseObject { (response: DataResponse<NewsResponse>) in
            switch response.result {
            case .success(let newsResponse):
                onSuccess(newsResponse.articles)
            case .failure( _):
                onError(PNMessages.ERROR_MESSAGE)
                break
            }
        }
    }
    
}

// MARK: Service URL

extension PNewsAPI{
    
    class func getNewsUrl(viewType: NewsViewType, keyword: String) -> String{
        switch viewType {
        case .newsListView:
            return PNApplicationInfo.APP_BASE_URL + "everything?domains=wsj.com&apiKey=" + PNApplicationInfo.API_KEY
        case .topHeadlineView:
            return PNApplicationInfo.APP_BASE_URL + "top-headlines?country=us&category=business&apiKey=" + PNApplicationInfo.API_KEY
        case .customNewsview:
            let today = Date().getToday()
            return PNApplicationInfo.APP_BASE_URL + "everything?q=" + keyword + "&from=\(today)&to=\(today)&sortBy=popularity&apiKey=" + PNApplicationInfo.API_KEY
        }
    }
}


