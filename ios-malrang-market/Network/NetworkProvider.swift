//
//  NetworkProvider.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation

protocol Provider {}

protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol

    func dataTask(
        with urlRequest: URLRequest,
        completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

final class NetworkProvider: Provider {
    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    private func checkError(
        with data: Data?,
        _ response: URLResponse?,
        error: Error?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        if let error = error {
            return completionHandler(.failure(error))
        }

        guard let response = response as? HTTPURLResponse else {
            return completionHandler(.failure(NetworkError.responseError))
        }

        guard (200..<300).contains(response.statusCode) else {
            return completionHandler(.failure(NetworkError.statusCodeError(statusCode: response.statusCode)))
        }

        guard let data = data else {
            return completionHandler(.failure(NetworkError.emptyDataError))
        }

        completionHandler(.success(data))
    }
}
