//
//  NewsApiDataManager.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/25.
//

import Foundation
import RxAlamofire
import RxSwift

final class NewsApiDataManager {
    
    static let shared = NewsApiDataManager()    
    private init() { }
    
    private let queue = ConcurrentDispatchQueueScheduler(qos: .background)
    
    func getCategoryNews(category: Category) -> Observable<NewsData>? {
        let params = [
            "category": category.categoryTitle,
            "country": COUNTRY,
            "apiKey": ApiKey.han.getApiKey
        ]
        
        return request(urlStr: CATEGORY_BASE_URL, params: params)
    }
    
    func getAllHeadLineNews() -> Observable<NewsData>? {
        let params = [
            "country": COUNTRY,
            "apiKey": ApiKey.han.getApiKey
        ]
        
        return request(urlStr: CATEGORY_BASE_URL, params: params)
    }
    
    func getSearchNews(searchTitle: String) -> Observable<NewsData>? {
        let params = [
            "q": searchTitle,
            "apiKey": ApiKey.han.getApiKey
        ]
        
        return request(urlStr: SEARCH_BASE_URL, params: params)
    }    
}

private extension NewsApiDataManager {
    func request(urlStr: String, params: [String : String]) -> Observable<NewsData>? {
        RxAlamofire.data(.get, urlStr, parameters: params)
            .observeOn(queue)
            .map { data -> NewsData in
                try JSONDecoder().decode(NewsData.self, from: data)
            }
    }
}
