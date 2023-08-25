//
//  NewsApiDataManager.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/25.
//

import Foundation
import Alamofire

final class NewsApiDataManager{
    
    static let shared = NewsApiDataManager()
    private let SEARCH_BASE_URL = "https://newsapi.org/v2/everything"
    private let CATEGORY_BASE_URL = "https://newsapi.org/v2/top-headlines"
    
    private init() { }
    
    func getCategoryNews(category: Category, completion: @escaping (NewsData?) -> Void) {
        guard let url = URL(string: CATEGORY_BASE_URL) else { return }
        let params = [
            "category": category.categoryTitle,
            "country": "kr",
            "apiKey": ApiKey.han.getApiKey
        ]
        
        request(url: url, params: params, completion: completion)
    }
    
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
