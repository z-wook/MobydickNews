import SnapKit
import UIKit

final class TableViewCell: UITableViewCell {
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .defaultPadding * 2
        
        [cellImageView, subStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        cellImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        return stackView
    }()
    
    private lazy var subStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = .defaultPadding
        
        [titleLabel, descriptionLabel, dateTimeLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { // 셀의 초기화 메서드
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // 셀을 생성할 때 호출되는 초기화 메서드
        super.init(coder: aDecoder)
    }
    
    private func commonInit() { // 공통 초기화 수행
        contentView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(title: String, description: String, date: String, imageString: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        dateTimeLabel.text = String(date.prefix(10))
        
        guard let imageString = imageString else { return }
        self.cellImageView.urlImageLoad(imageUrl: imageString)
    }
    
    // 셀 선택시 호출되는 메서드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
