//
//  URLSession.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/16.
//

import Foundation

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
//
extension URLSession: URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }

    func dataTask(
        with urlRequest: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return self.dataTask(with: urlRequest, completionHandler: completionHandler) as URLSessionDataTask
    }
}
