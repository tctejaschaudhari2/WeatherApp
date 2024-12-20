//
//  Current.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation

struct Current : Codable {

    let temp_c : Double?
    let condition : Condition?
    let humidity : Double?
    let feelslike_c : Double?
    let uv : Double?
    let dispTemp: String?
    let dispHumidity: String?
    let dispUV: String?
    let dispFeelsLike: String?

    enum CodingKeys: String, CodingKey {

        case temp_c = "temp_c"
        case condition = "condition"
        case humidity = "humidity"
        case feelslike_c = "feelslike_c"
        case uv = "uv"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
  
        temp_c = try values.decodeIfPresent(Double.self, forKey: .temp_c)
        condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
        humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        feelslike_c = try values.decodeIfPresent(Double.self, forKey: .feelslike_c)
        uv = try values.decodeIfPresent(Double.self, forKey: .uv)
        dispTemp = String(format: "%.1f", temp_c ?? 0.0)
        dispHumidity = String(format: "%.1f", humidity ?? 0.0)
        dispUV = String(format: "%.1f", uv ?? 0.0)
        dispFeelsLike = String(format: "%.1f", feelslike_c ?? 0.0)
        
    }

}
