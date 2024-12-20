//
//  Condition.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation

struct Condition : Codable {
    let icon : String?
    let iconUrl: String?

    enum CodingKeys: String, CodingKey {

        case icon = "icon"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        
        iconUrl = icon?.replacingOccurrences(of: "//", with: "https://")
    }

}
