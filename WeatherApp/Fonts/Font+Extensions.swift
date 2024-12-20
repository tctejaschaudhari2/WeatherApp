//
//  Font+Extensions.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation
import SwiftUI

enum FontWeight {
    case regular
    case medium
    case semiBold
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .regular:
            Font.custom("Poppins-Regular", size: size)
        case .medium:
            Font.custom("Poppins-Medium", size: size)
        case .semiBold:
            Font.custom("Poppins-SemiBold", size: size)
        }
    }
}
