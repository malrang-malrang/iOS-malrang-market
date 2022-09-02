//
//  NetworkProvider.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation
import RxSwift

protocol Provider {
    func request(endPoint: EndPoint) -> Observable<Data>
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

    func request(endPoint: EndPoint) -> Observable<Data> {
        return Single<Data>.create { single in
            let urlRequest: URLRequest

            switch endPoint.generateUrlRequest() {
            case .success(let request):
                urlRequest = request
            case .failure(let error):
                single(.failure(error))
                return Disposables.create()
            }

            let task = self.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let result = self?.checkError(with: data, response, error) else {
                    return
                }

                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create()
        }.asObservable()
    }

    private func checkError(
        with data: Data?,
        _ response: URLResponse?,
        _ error: Error?
    ) -> Result<Data, Error> {
        if let error = error {
            return .failure(error)
        }

        guard let response = response as? HTTPURLResponse else {
            return .failure(NetworkError.responseError)
        }

        guard (200..<300).contains(response.statusCode) else {
            return .failure(NetworkError.statusCodeError(statusCode: response.statusCode))
        }

        guard let data = data else {
            return .failure(NetworkError.emptyDataError)
        }

        return .success(data)
    }
}
