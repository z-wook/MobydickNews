//
//  DetailView.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/28.
//

import SnapKit
import UIKit

final class DetailView: UIView {
    
    public let viewModel = DetailViewModel()
    
    private let contentScrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    private let imageView = UIImageView()
    private let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp 메서드

    private func setUp() {
        setUpContentScrollView()
        setUpContentView()
        setUpTitleLabel()
        setUpInfoLabel()
        setUpImageView()
        setUpContentLabel()
    }

    private func setUpContentScrollView() {
        addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }

    private func setUpContentView() {
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    private func setUpTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = viewModel.data?.title ?? "제목 없음"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }

    private func setUpInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.textColor = .systemGray
        infoLabel.text = (viewModel.data?.author ?? "") + (viewModel.data?.publishedAt ?? "")
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.textAlignment = .right
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }

    private func setUpImageView() {
        contentView.addSubview(imageView)
//        imageView.image = viewModel.data?.urlToImage
        imageView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(CGFloat.defaultPadding)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
            make.height.equalTo(240)
        }
    }

    private func setUpContentLabel() {
        contentView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        contentLabel.text = viewModel.data?.content ?? "내용 없음"
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
            make.bottom.equalToSuperview()
        }
    }
}
