import SnapKit
import UIKit

final class TableViewCell: UITableViewCell {
    // 이미지 뷰를 감싸는 뷰
    private let imageViewContainer = UIView()
    private let cellImageView = UIImageView()
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
    }
    
    func configure(title: String, description: String, date: String, imageString: String?) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        
        dateTimeLabel.text = date
        dateTimeLabel.font = UIFont.systemFont(ofSize: 14)
        
        if let imageString = imageString, let url = URL(string: imageString) {
            // 이미지를 비동기적으로 가져와서 설정하는 코드
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cellImageView.image = image
                    }
                }
            }.resume()
        } else {
            cellImageView.image = UIImage(systemName: "pencil") // 기본 이미지로 "pencil" 사용
        }
    }
    
    // 셀 선택시 호출되는 메서드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
