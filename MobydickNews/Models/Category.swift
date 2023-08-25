//
//  Category.swift
//  MobydickNews
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

enum Category: String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var categoryTitle: String { rawValue }
}
