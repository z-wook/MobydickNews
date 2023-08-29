//
//  NewsHomeViewModel.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Combine

final class NewsHomeViewModel: ObservableObject {
    
    private let newsManager = NewsApiDataManager.shared
    let categoryFontSize: CGFloat = 15
    let categoryFontWeight: UIFont.Weight = .semibold
    @Published var newsList: NewsData?
    var select: Category = .business
    
    func getCategoryCellSize(categoryText: String) -> (CGFloat, CGFloat) {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.text = categoryText
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
    
    func getNewsData(category: Category) {
        select = category
        newsManager.getCategoryNews(category: category) { [weak self] newsData in
            guard let self = self else { return }
            self.newsList = newsData
        }
    }
}
