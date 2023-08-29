import SnapKit
import UIKit

final class NewsSearchPage: UIViewController {
    // 검색 바
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage() // Search바 기본구성인 두가지의 선을 지우는 ㄱ
        searchBar.placeholder = "검색할 단어를 입력해주세요"
        return searchBar
    }()
        
    // 검색 결과를 보여줄 테이블 뷰
    let searchTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var data: NewsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 테이블 뷰의 dataSource와 delegate를 설정
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        // Cell 등록
        searchTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        NewsApiDataManager.shared.getSearchNews(searchTitle: "apple") { [weak self] newsData in
            guard let self = self else { return }
            self.data = newsData
            self.searchTableView.reloadData()
        }
    }
    
    // UI 요소를 설정하는 메서드
    func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(searchTableView)
           
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.defaultPadding)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
           
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(CGFloat.defaultPadding)
            make.leading.trailing.bottom.equalToSuperview()
            // 탭 바 상단에 맞추어주는 코드
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension NewsSearchPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data,
              let articles = data.articles else {return 0}
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        guard let data = data,
              let articles = data.articles else { return UITableViewCell() }
        let temp = articles[indexPath.row]
        guard let title = temp.title,
              let description = temp.description,
              let date = temp.publishedAt,
              let image = temp.urlToImage else { return UITableViewCell() }
        
        cell.configure(title: title, description: description, date: date, imageString: image)
        return cell
    }
}
