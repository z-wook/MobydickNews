//
//  TabBarController.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

private extension TabBarController {
    func configure() {
        let newsHomeVC = UINavigationController(rootViewController: NewsHomePage())
        newsHomeVC.tabBarItem = UITabBarItem(
            title: "뉴스 홈",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper.fill")
        )
        
        let newsSearchVC = UINavigationController(rootViewController: NewsSearchPage())
        newsSearchVC.tabBarItem = UITabBarItem(
            title: "뉴스 서치",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "sparkle.magnifyingglass")
        )
        viewControllers = [newsHomeVC, newsSearchVC]
        tabBar.tintColor = .systemPink
    }
}
