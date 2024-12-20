//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by tejas chaudhari on 20/12/24.
//

import Foundation

// MARK: - RequestMethod

enum RequestMethod: String {
    case get
}

// MARK: - NetworkRouter

protocol NetworkRouter {
    var baseURLString: String { get }
    var method: RequestMethod? { get }
    var path: String { get }
    var params: [String: Any]? { get }
    func asURLRequest() throws -> URLRequest
}

// MARK: - Network Router Protocols impl

extension NetworkRouter {
    
    var baseURLString: String {
        return ""
    }
    
    // Add Rout method here
    var method: RequestMethod? {
        return .none
    }
    
    // Set APIs'Rout for each case
    var path: String {
        return ""
    }
    
    
    // Return each case parameters
    var params: [String: Any]? {
        return [:]
    }
    
    
    // MARK: URLRequest

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLString.appending(path))

        var urlRequest = URLRequest(url: url ?? URL(string: "google.com")!)
        urlRequest.httpMethod = method?.rawValue.uppercased()
        
        switch method {
        case .get:
            if var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: false), !params!.isEmpty {
                let query = params?.queryString
                let percentEncodedQuery = (urlComponents.percentEncodedQuery ?? "") + (query ?? "")
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
            
        default:
            break
        }
        
        return urlRequest
    }
    
    
}

