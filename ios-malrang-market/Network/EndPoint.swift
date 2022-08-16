//
//  EndPoint.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation

enum Endpoint {
    case healthChecker
    case productList(page: Int, itemsPerPage: Int)
    case detailProduct(id: Int)
    case productRegistration
}

extension Endpoint {
    var url: Result<URL, NetworkError> {
        switch self {
        case .healthChecker:
            return URL.generateEndpoint("healthChecker")
        case .productList(let page, let itemsPerPage):
            return URL.generateEndpoint("api/products?page_no=\(page)&items_per_page=\(itemsPerPage)")
        case .detailProduct(let id):
            return URL.generateEndpoint("api/products/\(id)")
        case .productRegistration:
            return URL.generateEndpoint("api/products")
        }
    }

    func urlRequest(httpMethod: HttpMethod) -> Result<URLRequest, NetworkError> {
        switch self.url {
        case .success(let url):
            return URLRequest.generateRequest(httpMethod: httpMethod, url: url)
        case .failure(let error):
            return .failure(error)
        }
    }
}

private extension URL {
    static let baseURL = "https://market-training.yagom-academy.kr/"

    static func generateEndpoint(_ endpoint: String) -> Result<URL, NetworkError> {
        guard let url = URL(string: baseURL + endpoint) else {
            return .failure(.urlError)
        }

        return .success(url)
    }
}

private extension URLRequest {
    static func generateRequest(httpMethod: HttpMethod, url: URL) -> Result<URLRequest, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.value

        return .success(request)
    }
}
