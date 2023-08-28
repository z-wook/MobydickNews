//
//  CategoryCell.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    private let viewModel = categoryViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: viewModel.categoryFontSize, weight: viewModel.categoryFontWeight)
        label.textAlignment = .center
        return label
    }()
    
    func configure(title: String) {
        contentView.backgroundColor = .systemOrange
        contentView.layer.cornerRadius = 17
        titleLabel.text = title
        
        setLayout()
    }
}

private extension CategoryCell {
    func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
