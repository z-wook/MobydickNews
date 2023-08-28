//
//  NewsTableViewCell.swift
//  MobydickNews
//
//  Created by t2023-m0050 on 2023/08/27.
//

import SnapKit
import UIKit

class TableViewCell: UITableViewCell {
    let imageViewContainer = UIView()
    let cellImageView = UIImageView(image: UIImage(systemName: "pencil"))
    let stackView = UIStackView()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Image View 설정
        cellImageView.image = UIImage(systemName: "pencil")
        cellImageView.contentMode = .scaleAspectFit
               
        // Image View Container 설정
        imageViewContainer.addSubview(cellImageView)
        imageViewContainer.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        cellImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
               
        // 스택뷰 설정
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(dateTimeLabel)
               
        // 메인 콘텐츠 스택뷰 설정
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.addArrangedSubview(imageViewContainer)
        mainStackView.addArrangedSubview(stackView)
               
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
            make.height.equalTo(100)
        }
        
        titleLabel.text = "안녕"
        descriptionLabel.text = "주어진 코드에서 에러가 발생하는 이유는 확장(extension)인 NewsSearchPage 클래스 내에서 UITableViewDelegate와 UITableViewDataSource 프로토콜의 메서드들을 구현하고 있는데, 해당 메서드들이 호출되면서 TableViewCell을 사용하려 할 때 발생하는 것으로 보입니다."
        dateTimeLabel.text = "2023/08/28"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
