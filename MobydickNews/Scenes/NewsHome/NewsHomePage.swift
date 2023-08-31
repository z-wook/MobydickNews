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
        viewModel.getNewsData(category: .business, page: viewModel.requestPage)
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
        viewModel.newsListSubject.bind { [weak self] needToReset in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if needToReset { self.tableView.scrollsToTop = true }
                self.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
}

extension NewsHomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                       for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let article = viewModel.articles[indexPath.row]
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
        let detailPageVC = NewsDetailPage()
        detailPageVC.bind(article: viewModel.articles[indexPath.row])
        navigationController?.pushViewController(detailPageVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        if viewModel.articles.count - currentRow == 5
            && viewModel.articles.count % currentRow == 5 {
            viewModel.getNewsData(category: viewModel.select, page: viewModel.requestPage)
        }
    }
}
