//
//  CategoryCell.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    let categoryFontSize: CGFloat = 15
    let categoryFontWeight: UIFont.Weight = .semibold
    private var select: Bool = false
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.textAlignment = .center
        return label
    }()
    
    func configure(category: Category) {
        contentView.backgroundColor = .systemOrange
        contentView.layer.cornerRadius = 17
        titleLabel.text = category.categoryTitle
        
        setLayout()
        setupCategory(isSelect: select)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                select = true
            } else {
                select = false
            }
            setupCategory(isSelect: select)
        }
    }
}

private extension CategoryCell {
    func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupCategory(isSelect: Bool) {
        if isSelect {
            contentView.addSubview(titleLabel)
            titleLabel.textColor = .systemOrange
            contentView.backgroundColor = .white
            
            contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.systemOrange.cgColor
        } else {
            contentView.addSubview(titleLabel)
            titleLabel.textColor = .white
            contentView.backgroundColor = .orange
            
            contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.systemOrange.cgColor
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
