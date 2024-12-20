//
//  WeatherComponentView.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import SwiftUI

struct WeatherComponentView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .customFont(.medium, 12)
                .foregroundStyle(.colorGray2)
            Text(value)
                .customFont(.medium, 15)
                .foregroundStyle(.colorGray1)
        }
        .frame(maxWidth: .infinity)
        .background(Color(.clear))
    }
}

#Preview {
    WeatherComponentView(label: "humidity", value: "46%")
}
