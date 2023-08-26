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
    
    // MARK: - 메서드
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
        contentView.backgroundColor = .yellow
        contentView.snp.makeConstraints{ make in
            make.centerX.top.bottom.equalToSuperview()
            make.width.equalTo(contentScrollView.snp.width)
        }
    }
    private func setUpTitleLabel(){
        contentView.addSubview(titleLabel)
        titleLabel.text = "titleLabel"
        titleLabel.backgroundColor = .red
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }
    private func setUpInfoLabel(){
        contentView.addSubview(infoLabel)
        infoLabel.text = "info Label"
        infoLabel.backgroundColor = .red
        infoLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
        }
    }
    private func setUpImageView(){
        contentView.addSubview(imageView)
        imageView.backgroundColor = .red
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
        contentLabel.backgroundColor = .red
        contentLabel.text = "하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이하이ㅍ"
        contentLabel.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.defaultPadding)
            make.left.equalToSuperview().offset(CGFloat.defaultPadding)
            make.right.equalToSuperview().offset(-CGFloat.defaultPadding)
            make.bottom.equalToSuperview()
        }
    }
    
}
