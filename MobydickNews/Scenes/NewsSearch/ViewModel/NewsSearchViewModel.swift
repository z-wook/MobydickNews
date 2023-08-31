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
    // Subject - 이벤트를 발생 시키면서 Observable 형태도 되는 것
    let newsListSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    func getAllHeadLineNews() {
        newsManager.getAllHeadLineNews()?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                self.newsList = newsData
                newsListSubject.onNext(())
            }).disposed(by: disposeBag)
    }

    func getSearchNewsData(searchTitle: String) {
        newsManager.getSearchNews(searchTitle: searchTitle)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                self.newsList = newsData
                newsListSubject.onNext(())
            }).disposed(by: disposeBag)
    }

    func filteredArticle() -> [Article]? {
        guard let newsList = newsList,
              let articles = newsList.articles else { return nil }

        return articles.compactMap { article in
            if article.title != nil && article.content != nil { return article }
            return nil
        }
    }
}
