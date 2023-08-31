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
    var articles: [Article] = []
    
    // Subject - 이벤트를 발생 시키면서 Observable 형태도 되는 것
    let newsListSubject = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    var requestPage: Int = 0
    
    func getCategoryCellSize(categoryText: String) -> (CGFloat, CGFloat) {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.text = categoryText
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
    
    func getNewsData(isNeededToReset: Bool = false, category: Category, page: Int) {
        select = category
        
        if isNeededToReset == true {
            requestPage = 0
            articles = []
        }
        
        if page == 3 { return }
        
        newsManager.getCategoryNews(category: category, page: page)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                if let articles = newsData.articles {
                    self.articles += filteredArticle(articles: articles)
                    self.requestPage += 1
                }
                newsListSubject.onNext(isNeededToReset)
            }).disposed(by: disposeBag)
    }
    
    private func filteredArticle(articles: [Article]) -> [Article] {
        return articles.compactMap { article in
            if article.title != nil && article.content != nil { return article }
            return nil
        }
    }
}
