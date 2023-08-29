//
//  DetailViewModel.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/28.
//

import Foundation

final class NewsDetailViewModel{
    
    public var data:Article?
    
    public func bind(data:Article){
        self.data = data
    }
    
}
