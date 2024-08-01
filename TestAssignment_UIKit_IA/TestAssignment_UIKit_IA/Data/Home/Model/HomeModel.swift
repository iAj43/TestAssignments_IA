//
//  HomeModel.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import Foundation

struct MealTypesData: Decodable {
    
    let mealTypes: [MealTypesDetailData]?
    
    enum CodingKeys: String, CodingKey {
        case mealTypes = "meal_types"
    }
}

struct MealTypesDetailData: Decodable {
    
    let typeImage: String?
    let typeTitle: String?
    let listData: [ListData]?
    
    enum CodingKeys: String, CodingKey {
        case typeImage = "type_image"
        case typeTitle = "type_title"
        case listData
    }
}

struct ListData: Decodable, Hashable {
    
    let image: String?
    let title: String?
    let subtitle: String?
    
    enum CodingKeys: String, CodingKey {
        case image
        case title
        case subtitle
    }
}
