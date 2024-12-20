//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel())
        }
    }
}
