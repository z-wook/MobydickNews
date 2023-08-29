//
//  UIImageView+.swift
//  MobydickNews
//
//  Created by SeoJunYoung on 2023/08/29.
//

import Foundation
import UIKit

extension UIImageView{
    func urlImageLoad(imageUrl:String){
        if let url = URL(string: imageUrl) {
            // 이미지를 비동기적으로 가져와서 설정하는 코드
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        } else {
            self.image = UIImage(systemName: "photo")
        }
    }
}
