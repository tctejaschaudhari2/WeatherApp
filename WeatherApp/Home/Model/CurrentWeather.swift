//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation

struct CurrentWeather : Codable {
    
    let location : Location?
    let current : Current?
    let error : ErrorMsg?

    enum CodingKeys: String, CodingKey {

        case location = "location"
        case current = "current"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        current = try values.decodeIfPresent(Current.self, forKey: .current)
        error = try values.decodeIfPresent(ErrorMsg.self, forKey: .error)

    }

}
