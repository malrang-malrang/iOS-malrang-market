//
//  MockURLSession.swift
//  ios-malrang-marketTests
//
//  Created by 김동욱 on 2022/08/17.
//

@testable import ios_malrang_market
import UIKit

struct MockData {
    func load() -> Data? {
        guard let asset = NSDataAsset(name: "products") else {
            return nil
        }
        return asset.data
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
}

class MockURLSession: URLSessionProtocol {
    var isRequestSuccess: Bool

    init(isRequestSuccess: Bool = true) {
        self.isRequestSuccess = isRequestSuccess
    }

    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        let sucessResponse = HTTPURLResponse(
            url: url,
            statusCode: 200, httpVersion: "",
            headerFields: nil
        )

        let failureResponse = HTTPURLResponse(
            url: url,
            statusCode: 400, httpVersion: "",
            headerFields: nil
        )

        if isRequestSuccess {
            return MockURLSessionDataTask {
                completionHandler(MockData().load(), sucessResponse, nil)
            }
        } else {
            return MockURLSessionDataTask {
                completionHandler(MockData().load(), failureResponse, nil)
            }
        }
    }

    func dataTask(
        with urlRequest: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        let sucessResponse = HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: 200, httpVersion: "",
            headerFields: nil
        )

        let failureResponse = HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: 400, httpVersion: "",
            headerFields: nil
        )

        if isRequestSuccess {
            return MockURLSessionDataTask {
                completionHandler(MockData().load(), sucessResponse, nil)
            }
        } else {
            return MockURLSessionDataTask {
                completionHandler(MockData().load(), failureResponse, nil)
            }
        }
    }
}
