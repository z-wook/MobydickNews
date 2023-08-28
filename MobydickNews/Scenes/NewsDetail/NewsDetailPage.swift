//
//  NewsDetailPage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import SnapKit
import UIKit

final class NewsDetailPage: UIViewController {

    private let detailView = DetailView()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
    }

}
