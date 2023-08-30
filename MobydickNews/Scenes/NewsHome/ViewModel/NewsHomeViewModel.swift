//
//  NewsHomeViewModel.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import RxSwift

final class NewsHomeViewModel: ObservableObject {
    
    private let newsManager = NewsApiDataManager.shared
    private let categoryFontSize: CGFloat = 15
    private let categoryFontWeight: UIFont.Weight = .semibold
    var select: Category = .business
    var newsList: NewsData?
    // Subject - 이벤트를 발생 시키면서 Observable 형태도 되는 것
    let newsListSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    func getCategoryCellSize(categoryText: String) -> (CGFloat, CGFloat) {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.text = categoryText
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
    
    func getNewsData(category: Category) {
        select = category
        
        newsManager.getCategoryNews(category: category)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                self.newsList = newsData
                newsListSubject.onNext(Void())
            }).disposed(by: disposeBag)
    }
    
    func filteredArticle() -> [Article]? {
        guard let newsList = newsList,
              let articles = newsList.articles else { return nil }
        
        return articles.compactMap { article in
            if article.title != nil { return article }
            return nil
        }
    }
}
