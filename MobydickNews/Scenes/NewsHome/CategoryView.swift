//
//  CategoryView.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

class CategoryView: UIView {
    
    private var viewModel: NewsHomeViewModel?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.contentInset = .init(top: 0, left: .defaultPadding, bottom: 0, right: .defaultPadding)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(viewModel: NewsHomeViewModel) {
        super.init(frame: .zero)
        
        self.viewModel = viewModel
        setLayout()
    }
    
    private func setLayout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier,
                                                            for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        let category = Category.allCases[indexPath.row]
        cell.configure(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { return CGSize() }
        let categoryTitle = Category.allCases[indexPath.row].categoryTitle
        let size = viewModel.getCategoryCellSize(categoryText: categoryTitle)
        let cellInset: CGFloat = 20
        return CGSize(width: size.0 + cellInset, height: size.1 + cellInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let category = Category.allCases[indexPath.row]
        viewModel.getNewsData(isNeededToReset: true, category: category, page: 1)
    }
}
