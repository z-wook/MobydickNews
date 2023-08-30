//
//  NewsApiDataManager.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/25.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

final class NewsApiDataManager {
    
    static let shared = NewsApiDataManager()    
    private init() { }
    
    private let queue = ConcurrentDispatchQueueScheduler(qos: .background)
    
    let temp = DispatchQueue.global()
    
    
    func getCategoryNews(category: Category) -> Observable<NewsData>? {
        let params = [
            "category": category.categoryTitle,
            "country": COUNTRY,
            "apiKey": ApiKey.han.getApiKey
        ]
        
//        RxAlamofire.
        
        return RxAlamofire.data(.get, CATEGORY_BASE_URL, parameters: params)
//            .debug()
            .observeOn(queue)
            .map { data -> NewsData in
                return try JSONDecoder().decode(NewsData.self, from: data)
            }
    }
    
    func getAllHeadLineNews(completion: @escaping (NewsData?) -> Void) {
        guard let url = URL(string: CATEGORY_BASE_URL) else { return }
        let params = [
            "country": COUNTRY,
            "apiKey": ApiKey.han.getApiKey
        ]
        
        request(url: url, params: params, completion: completion)
    }
    
//    func getCategoryNews(category: Category, completion: @escaping (NewsData?) -> Void) {
//        guard let url = URL(string: CATEGORY_BASE_URL) else { return }
//        let params = [
//            "category": category.categoryTitle,
//            "country": COUNTRY,
//            "apiKey": ApiKey.han.getApiKey
//        ]
//
//        request(url: url, params: params, completion: completion)
//    }
    
    func getSearchNews(searchTitle: String, completion: @escaping (NewsData?) -> Void) {
        guard let url = URL(string: SEARCH_BASE_URL) else { return }
        let params = [
            "q": searchTitle,
            "apiKey": ApiKey.han.getApiKey
        ]
        
        request(url: url, params: params, completion: completion)
    }    
}

private extension NewsApiDataManager {
    func request(url: URL, params: [String : String], completion: @escaping (NewsData?) -> Void) {
        AF.request(url, method: .get, parameters: params)
            .responseDecodable(of: NewsData.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result)

                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
