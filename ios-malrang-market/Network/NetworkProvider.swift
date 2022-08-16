//
//  NetworkProvider.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation

protocol Provider {
    func fatchData<T: Decodable>(
        from endPoint: Endpoint,
        completionHandler: @escaping (Result<T, Error>) -> Void
    )
}

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

    func fatchData<T: Decodable>(
        from endPoint: Endpoint,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        let urlRequest = endPoint.urlRequest(httpMethod: .get)

        switch urlRequest {
        case .success(let urlRequest):
            self.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
                self?.checkError(with: data, response, error: error, completionHandler: { result in
                    switch result {
                    case .success(let data):
                        completionHandler(data.decode())
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                })
            }.resume()
        case .failure(let error):
            completionHandler(.failure(error))
        }
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
