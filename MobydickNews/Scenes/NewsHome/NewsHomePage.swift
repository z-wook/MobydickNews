//
//  NewsHomePage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Combine
import SnapKit
import RxSwift

final class NewsHomePage: UIViewController {
    
    private let viewModel = NewsHomeViewModel()
    private var categoryView: CategoryView
    private var cancelable = Set<AnyCancellable>()
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }()
    
    init() {
        categoryView = CategoryView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        bindViewModel()
        viewModel.getNewsData(category: .business)
    }
}

private extension NewsHomePage {
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.newsListSubject.bind { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
}

extension NewsHomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = viewModel.filteredArticle() else { return 0 }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                       for: indexPath) as? TableViewCell,
              let articles = viewModel.filteredArticle() else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.configure(title: article.title,
                       description: article.description,
                       date: article.publishedAt,
                       imageString: article.urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return categoryView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articles = viewModel.filteredArticle() else { return }
        let detailPageVC = NewsDetailPage()
        detailPageVC.bind(article: articles[indexPath.row])
        navigationController?.pushViewController(detailPageVC, animated: true)
    }
}
