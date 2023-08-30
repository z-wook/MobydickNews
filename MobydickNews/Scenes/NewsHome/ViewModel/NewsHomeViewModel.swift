//
//  NewsHomeViewModel.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Combine
import RxSwift

final class NewsHomeViewModel: ObservableObject {
    
    private let newsManager = NewsApiDataManager.shared
    private let categoryFontSize: CGFloat = 15
    private let categoryFontWeight: UIFont.Weight = .semibold
//    @Published var newsList: NewsData?
    var newsList: NewsData?
    // Subject - 이벤트를 발생 시키면서 Observable 형태도 되는 것
    let newsListSubject = PublishSubject<Void>()
    
    
    var select: Category = .business
    private let disposeBag = DisposeBag()
    
    var aaa: Observable<NewsData>?
    
    
    func getCategoryCellSize(categoryText: String) -> (CGFloat, CGFloat) {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.text = categoryText
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
    
    func getNewsData(category: Category) {
        select = category
//        newsManager.getCategoryNews(category: category) { [weak self] newsData in
//            guard let self = self else { return }
//            self.newsList = newsData
//        }
        
        newsManager.getCategoryNews(category: category)?
            .bind(onNext: { [weak self] newsData in
                guard let self = self else { return }
                self.newsList = newsData
                newsListSubject.onNext(Void())
            }).disposed(by: disposeBag)
        
//            .subscribe(onNext: { newsData in
//                self.newsList =  newsData
//            })
//            .disposed(by: disposeBag)
        
        
//        observable?.bind(onNext: { newsData in
//            self.newsList = newsData
//        }).disposed(by: disposeBag)
    }
}
