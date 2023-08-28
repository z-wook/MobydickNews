//
//  NewsDetailPage.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class NewsDetailPage: UIViewController {
    
    private let contentScrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    private let imageView = UIImageView()
    private let contentLabel = UILabel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - SetUp 메서드
    private func setUp(){
        setUpContentScrollView()
        setUpContentView()
        setUpTitleLabel()
        setUpInfoLabel()
        setUpImageView()
        setUpContentLabel()
    }
    private func setUpContentScrollView(){
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func setUpContentView(){
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    private func setUpTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.text = "titleLabel"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }
    private func setUpInfoLabel(){
        contentView.addSubview(infoLabel)
        infoLabel.textColor = .systemGray
        infoLabel.text = "info Label"
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.textAlignment = .right
        infoLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }
    private func setUpImageView(){
        contentView.addSubview(imageView)
        imageView.image = UIImage(systemName: "photo")
        imageView.snp.makeConstraints{ make in
            make.top.equalTo(infoLabel.snp.bottom).offset(CGFloat.defaultPadding)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
            make.height.equalTo(240)
        }
    }
    private func setUpContentLabel(){
        contentView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        contentLabel.text = "contentLabel"
        contentLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
            make.bottom.equalToSuperview()
        }
    }
    // MARK: - 일반 메서드
    public func bind(data:Article){
        titleLabel.text = data.title
        infoLabel.text = (data.author ?? "") + (data.publishedAt ?? "")
        //img
        contentLabel.text = (data.content ?? "내용 없음")
    }

}
