import SnapKit
import UIKit

final class TableViewCell: UITableViewCell {
    // 이미지 뷰를 감싸는 뷰
    private let imageViewContainer = UIView()
    private let cellImageView = UIImageView(image: UIImage(systemName: "pencil"))
    private let stackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // 셀의 초기화 메서드
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // 셀을 생성할 때 호출되는 초기화 메서드
        super.init(coder: aDecoder)
    }
    
    private func commonInit() { // 공통 초기화 수행
        // Image View 설정
        cellImageView.image = UIImage(systemName: "pencil")
        cellImageView.contentMode = .scaleAspectFit
               
        // Image View Container 설정
        // Image View에 cellImageview를 추가하고 크기 제약 설정
        imageViewContainer.addSubview(cellImageView)
        imageViewContainer.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        cellImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
               
        // 스택뷰 설정 (라벨 설정 및 간격 설정)
        stackView.axis = .vertical
        stackView.spacing = .defaultPadding
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateTimeLabel)
               
        // 메인 콘텐츠 스택뷰 설정 (imageViewContainer + stackView 가로 배열 설정)
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = .defaultPadding * 2
        mainStackView.addArrangedSubview(imageViewContainer)
        mainStackView.addArrangedSubview(stackView)
               
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(
                top: .defaultPadding,
                left: .defaultPadding * 2,
                bottom: .defaultPadding,
                right: .defaultPadding * 2
            )
            )
            make.height.equalTo(100)
        }
        
//        titleLabel.text = "안녕"
//        descriptionLabel.text = "주어진 코드에서 에러가 발생하는 이유는 확장(extension)인 NewsSearchPage 클래스 내에서 UITableViewDelegate와 UITableViewDataSource 프로토콜의 메서드들을 구현하고 있는데, 해당 메서드들이 호출되면서 TableViewCell을 사용하려 할 때 발생하는 것으로 보입니다."
//        descriptionLabel.numberOfLines = 2
//        dateTimeLabel.text = "2023/08/28"
    }
    
    func configure(title: String, description: String, date: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 2
        dateTimeLabel.text = date
    }
    
    // 셀 선택시 호출되는 메서드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
