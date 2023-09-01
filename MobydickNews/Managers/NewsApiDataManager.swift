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
    
    func getCategoryNews(category: Category, page: Int) -> Observable<NewsData>? {
        let params: [String: Any] = [
            "category": category.categoryTitle,
            "country": COUNTRY,
            "page": page,
            "apiKey": ApiKey.test.getApiKey
        ]
        
        return request(urlStr: CATEGORY_BASE_URL, params: params)
    }
    
    func getAllHeadLineNews(page: Int) -> Observable<NewsData>? {
        let params: [String: Any] = [
            "country": COUNTRY,
            "page": page,
            "apiKey": ApiKey.test.getApiKey
        ]
        
        return request(urlStr: CATEGORY_BASE_URL, params: params)
    }
    
    func getSearchNews(searchTitle: String) -> Observable<NewsData>? {
        let params: [String: Any] = [
            "q": searchTitle,
            "apiKey": ApiKey.test.getApiKey
        ]
        
        return request(urlStr: SEARCH_BASE_URL, params: params)
    }    
}

private extension NewsApiDataManager {
    func request(urlStr: String, params: [String: Any]) -> Observable<NewsData>? {
        RxAlamofire.data(.get, urlStr, parameters: params)
            .observeOn(queue)
            .map { data -> NewsData in
                try JSONDecoder().decode(NewsData.self, from: data)
            }
    }
}
