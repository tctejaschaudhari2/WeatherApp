//
//  Text+Extensions.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation
import SwiftUI

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
