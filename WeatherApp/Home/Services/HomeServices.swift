//
//  HomeServices.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation
import Combine

// MARK: - HomeServicesProtocols

protocol HomeServicesProtocols {
    func fetchCurrentLocationWeather(searchQuery: String) -> AnyPublisher<CurrentWeather, APIErrors> //AnyPublisher<AnyModel, AFError>
}

// MARK: - HomeServices

class HomeServices {
    // MARK: Lifecycle

    init(apiRequest: APIRequest) {
        self.apiRequest = apiRequest
    }

    deinit {
        debugPrint("Home Services deinited")
    }

    // MARK: Private

    private var apiRequest: APIRequest
}

// MARK: Using HomeServicesProtocols

extension HomeServices: HomeServicesProtocols {
    func fetchCurrentLocationWeather(searchQuery: String) -> AnyPublisher<CurrentWeather, APIErrors> {
        self.apiRequest.request(HomeRouter.fetchCurrentLocationWeather(searchQuery: searchQuery))
    }
}

extension HomeServices {
    enum HomeRouter: NetworkRouter {
        case fetchCurrentLocationWeather(searchQuery: String)

        // MARK: Internal

        var baseURLString: String {
            return APIConstant.kBaseUrl
        }

        var path: String {
            let finalPath = "\(APIConstant.kCurrent)"
            return finalPath
        }

        var method: RequestMethod? {
            return .get
        }
        
        var params: [String: Any]? {
            var dictionary = [String: Any]()
            switch self {
            case .fetchCurrentLocationWeather(let searchQuery):
                dictionary.updateValue(searchQuery, forKey: "q")
                dictionary.updateValue("en", forKey: "lang")
                dictionary.updateValue(APIConstant.kAPIKey, forKey: "key")
            }
            return dictionary
        }


    }
}
