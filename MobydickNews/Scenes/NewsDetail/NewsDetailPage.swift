//
//  NewsDetailPage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class NewsDetailPage: UIViewController {

    private let detailView = NewsDetailView()
    private let viewModel = NewsDetailViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView

    }
    public func viewLoad(){
        guard let acticle = viewModel.data else { return }
        detailView.bind(data: acticle)
    }
    public func bind(article:Article){
        viewModel.bind(data: article)
        viewLoad()
    }

}

