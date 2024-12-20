//
//  APIRequest.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation

import Combine

// MARK: - APIRequestProtocols

protocol APIRequestProtocols {
    func request<T: Codable>(_ endpoint: NetworkRouter) -> AnyPublisher<T, APIErrors>
}

// MARK: - ErrorHandling

enum APIErrors: Error {
    case unkownError(String)
}

// MARK: - APIRequest

class APIRequest {
    // MARK: Private

    private var urlSessionManager: URLSession
    
    // MARK: Lifecycle

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.multipathServiceType = .handover
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.urlSessionManager = URLSession(configuration: configuration)
    }
    
    deinit{
        debugPrint("APIRequest deinited")
    }
}

// MARK: APIRequestProtocols

extension APIRequest: APIRequestProtocols {
    func request<T>(_ endpoint: NetworkRouter) -> AnyPublisher<T, APIErrors> where T : Decodable, T : Encodable {
        do {
            let urlRequest = try endpoint.asURLRequest()
            return urlSessionManager.dataTaskPublisher(for: urlRequest)
                .subscribe(on: DispatchQueue.main)
                .tryMap{ element -> JSONDecoder.Input in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 || httpResponse.statusCode == 400 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError{ (error) -> APIErrors in
                    if let apiErrors = error as? APIErrors {
                        return apiErrors
                    }
                    return APIErrors.unkownError("error")
                        
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIErrors.unkownError("unkown Error occured: \(error.localizedDescription)")).eraseToAnyPublisher()
        }
    }
    

}
