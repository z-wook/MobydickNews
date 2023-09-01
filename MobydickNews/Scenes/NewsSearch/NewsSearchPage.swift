import RxSwift
import SnapKit
import UIKit

final class NewsSearchPage: UIViewController {
    private let viewModel = NewsSearchViewModel()
    private let disposeBag = DisposeBag()
    // 검색 바
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage() // Search바 기본구성인 두가지의 선을 지우는 ㄱ
        searchBar.placeholder = "검색할 단어를 입력해주세요"
        return searchBar
    }()
    
    // 검색 결과를 보여줄 테이블 뷰
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        // Cell 등록
        searchTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        setupUI()
        bindViewModel()
        viewModel.getAllHeadLineNews(page: viewModel.requestPage)
        
        // 키보드 내려가게하기
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(navigationBarTapped))
        navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func navigationBarTapped() {
        // 키보드 내리기
        view.endEditing(true)
    }

    func bindViewModel() {
        viewModel.newsListSubject.bind { [weak self] needToReset in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if needToReset { self.searchTableView.scrollsToTop = true }
                self.searchTableView.reloadData()
            }
        }.disposed(by: disposeBag)
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

extension NewsSearchPage: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            viewModel.getSearchNewsData(isNeededToReset: true, searchTitle: query)
        }
        searchBar.resignFirstResponder() // 엔터를 치면 키보드 사라짐
    }
}

extension NewsSearchPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let article = viewModel.articles[indexPath.row]
        cell.configure(title: article.title, description: article.description, date: article.publishedAt, imageString: article.urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPageVC = NewsDetailPage()
        detailPageVC.bind(article: viewModel.articles[indexPath.row])
        navigationController?.pushViewController(detailPageVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        let totalCount = viewModel.articles.count
        if totalCount - currentRow == 5 && totalCount % currentRow == 5 {
            if searchBar.text?.isEmpty == true {
                viewModel.getAllHeadLineNews(page: viewModel.requestPage)
            }
        }
    }
}
