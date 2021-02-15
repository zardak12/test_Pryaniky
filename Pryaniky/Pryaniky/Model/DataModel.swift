//
//  DataModel.swift
//  Pryaniky
//
//  Created by Марк Шнейдерман on 12.02.2021.
//

import Foundation

// MARK: - Model
struct Model: Codable {
    let data: [MyData]
    let view: [String]

}

// MARK: - Data
struct MyData: Codable {
    let name: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text
        case url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}
