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
                _ = self?.checkError(with: data, response, error)
                    .subscribe(onSuccess: { data in
                    single(.success(data))
                }, onFailure: { error in
                    single(.failure(error))
                })
            }
            task.resume()
            return Disposables.create()
        }.asObservable()
    }
    //리절트 써도됨
    private func checkError(
        with data: Data?,
        _ response: URLResponse?,
        _ error: Error?
    ) -> Single<Data> {
        return Single<Data>.create { single in
            if let error = error {
                single(.failure(error))
                return Disposables.create()
            }

            guard let response = response as? HTTPURLResponse else {
                single(.failure(NetworkError.responseError))
                return Disposables.create()
            }

            guard (200..<300).contains(response.statusCode) else {
                single(.failure(NetworkError.statusCodeError(statusCode: response.statusCode)))
                return Disposables.create()
            }

            guard let data = data else {
                single(.failure(NetworkError.emptyDataError))
                return Disposables.create()
            }

            single(.success(data))
            return Disposables.create()
        }
    }
}
