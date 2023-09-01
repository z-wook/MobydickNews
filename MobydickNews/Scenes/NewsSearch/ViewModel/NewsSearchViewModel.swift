//
//  NewsSearchViewModel.swift
//  MobydickNews
//
//  Created by t2023-m0050 on 2023/08/29.
//

// import Combine
import Foundation
import RxSwift

final class NewsSearchViewModel: ObservableObject {
    private let newsManager = NewsApiDataManager.shared
    var newsList: NewsData?
    //
    var articles: [Article] = []
    var requestPage: Int = 0
    //
    let newsListSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()

    func getAllHeadLineNews(isNeededToReset: Bool = false, page: Int) {
        if isNeededToReset == true {
            requestPage = 0
            articles = []
        }
        
        if page == 3 { return }
        
        newsManager.getAllHeadLineNews(page: requestPage)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                if let articles = newsData.articles {
                    self.articles += filteredArticle(articles: articles)
                    self.requestPage += 1
                }
                newsListSubject.onNext(isNeededToReset)
            }).disposed(by: disposeBag)
    }

    func getSearchNewsData(isNeededToReset: Bool = false, searchTitle: String) {
        if isNeededToReset == true {
            requestPage = 0
            articles = []
        }
        newsManager.getSearchNews(searchTitle: searchTitle)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                if let articles = newsData.articles {
                    self.articles += filteredArticle(articles: articles)
                }
                print("~~~~~> articles: \(articles)")
                newsListSubject.onNext(isNeededToReset)
            }).disposed(by: disposeBag)
    }

    func filteredArticle(articles: [Article]) -> [Article] {
        return articles.compactMap { article in
            if article.title != nil && article.content != nil { return article }
            return nil
        }
    }
}
