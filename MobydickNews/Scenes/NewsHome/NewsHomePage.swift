//
//  NewsHomePage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Combine
import SnapKit

final class NewsHomePage: UIViewController {
    
    private let viewModel = NewsHomeViewModel()
    private var cancelable = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        bindViewModel()
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
        viewModel.$newsList.receive(on: DispatchQueue.main)
            .sink { [weak self] newsList in
                guard let self = self,
                      let articles = newsList?.articles else { return }
                if !articles.isEmpty {
                    self.tableView.reloadData()
                }
            }.store(in: &cancelable)
    }
}

extension NewsHomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = viewModel.newsList?.articles else { return 0 }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                       for: indexPath) as? TableViewCell,
              let articles = viewModel.newsList?.articles else { return UITableViewCell() }
        let article = articles[indexPath.row]
        if let title = article.title,
           let description = article.description,
           let date = article.publishedAt {
            cell.configure(title: title, description: description, date: date)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CategoryView(viewModel: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.newsList?.articles?[indexPath.row])
        let detailPageVC = NewsDetailPage()
        navigationController?.pushViewController(detailPageVC, animated: true)
    }
}
