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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         할일
         1. 테이블 뷰 셀 (공통 부분 만들기)
         2. 서치바 만들기
         3.  NewsApiDataManager을 사용하여
         **/
        setupUI()
        
        // 테이블 뷰의 dataSource와 delegate를 설정
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        // Cell 등록
        searchTableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
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
               make.top.equalTo(searchBar.snp.bottom).offset(16)
               make.leading.trailing.bottom.equalToSuperview()
           }
       }
       
}

extension NewsSearchPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
//        cell.imageView?.image = UIImage(systemName: "person")
//        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}
