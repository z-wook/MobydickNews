//
//  categoryViewModel.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class categoryViewModel {
    let categoryFontSize: CGFloat = 15
    let categoryFontWeight: UIFont.Weight = .semibold
    
    func getCategoryCellSize(categoryText: String) -> (CGFloat, CGFloat) {
        let label = UILabel()
        label.font = .systemFont(ofSize: categoryFontSize, weight: categoryFontWeight)
        label.text = categoryText
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
}
