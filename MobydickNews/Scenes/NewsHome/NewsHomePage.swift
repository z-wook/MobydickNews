//
//  NewsHomePage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class NewsHomePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(CGFloat.padding)
        }
    }
}
