//
//  weatherIconView.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import SwiftUI

struct weatherIconView: View {
    let iconUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: iconUrl)){ phase in
            switch phase {
            case .empty:
                ProgressView() // Show a progress indicator while loading
            case .success(let image):
                image.resizable().scaledToFit() // Display the loaded image
            case .failure:
                Image(systemName: "cloud.fill") // Fallback image
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.blue)
            @unknown default:
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.blue)
            }
            
        }
        .frame(width: 120, height: 90)
    }
}

#Preview {
    weatherIconView(iconUrl: "")
}
