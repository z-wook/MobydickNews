//
//  NewsSearchViewModel.swift
//  MobydickNews
//
//  Created by t2023-m0050 on 2023/08/29.
//

import Combine
import Foundation

final class NewsSearchViewModel: ObservableObject {
    private let newsManager = NewsApiDataManager.shared
    @Published var newsList: NewsData?

    func getAllHeadLineNews() {
        newsManager.getAllHeadLineNews { [weak self] newsData in
            guard let self = self else { return }
            self.newsList = newsData
        }
    }

    func getSearchNewsData(searchTitle: String) {
        newsManager.getSearchNews(searchTitle: searchTitle) { [weak self] newsData in
            guard let self = self else { return }
            self.newsList = newsData
        }
    }
}


