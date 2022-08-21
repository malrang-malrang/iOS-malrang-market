//
//  Requestable.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/20.
//

import Foundation

import RxSwift

private enum Const {
    static let emptyString = ""
}

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
    var sampleData: Data? { get }
}

extension Requestable {
    func generateUrlRequest() -> Result<URLRequest, NetworkError> {
        var urlRequest: URLRequest

        switch self.generateURL() {
        case.success(let url):
            urlRequest = URLRequest(url: url)
        case.failure(let error):
            return .failure(error)
        }

        if let bodyParameters = self.bodyParameters?.toDictionary() {
            switch bodyParameters {
            case.success(let body):
                if body.isEmpty == false {
                    do {
                        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
                    } catch {
                        return .failure(.decodeError)
                    }
                }
            case.failure(let error):
                return .failure(error)
            }
        }

        urlRequest.httpMethod = method.rawValue
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        return .success(urlRequest)
    }

    func generateUrlRequestMultiPartFormData() -> Result<URLRequest, NetworkError> {
        let url = generateURL()
        var urlRequest: URLRequest

        switch url {
        case.success(let url):
            urlRequest = URLRequest(url: url)
        case.failure(let error):
            return .failure(error)
        }

        if let productsPost = bodyParameters as? ProductRequest,
           let body = generateBody(productsPost) {
            urlRequest.httpBody = body
        }

        urlRequest.httpMethod = method.rawValue
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        return .success(urlRequest)
    }

    private func generateBody(_ productInfomation: ProductRequest) -> Data? {
        var body: Data = Data()
        let boundary = productInfomation.boundary ?? Const.emptyString

        guard let data = try? Json.encoder.encode(productInfomation) else {
            return nil
        }

        let multiPartFormData = self.convertDataToMultiPartForm(data: data, boundary: boundary)
        body.append(multiPartFormData)

        productInfomation.imageInfos?.forEach { imageInfo in
            let image = self.convertFileMultiPartForm(imageInfo: imageInfo, boundary: boundary)
            body.append(image)
        }

        body.appendString("\r\n--\(boundary)--\r\n")
        return body
    }

    private func convertDataToMultiPartForm(data: Data, boundary: String) -> Data {
        var data = Data()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"params\"")
        data.appendString("\r\n")
        data.appendString("\r\n")
        data.append(data)
        data.appendString("\r\n")

        return data
    }

    private func convertFileMultiPartForm(imageInfo: ImageInfo, boundary: String) -> Data {
        var data = Data()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"images\"; filename=\"\(imageInfo.fileName)\"")
        data.appendString("\r\n")
        data.appendString("Content-Type: image/\(imageInfo.type.description)")
        data.appendString("\r\n")
        data.appendString("\r\n")
        data.append(imageInfo.data)
        data.appendString("\r\n")

        return data
    }

    private func generateURL() -> Result<URL, NetworkError> {
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else {
            return .failure(.urlComponetError)
        }

        var urlQueryItems = [URLQueryItem]()
        if let queryParameters = self.queryParameters?.toDictionary() {
            switch queryParameters {
            case.success(let data):
                data.forEach {
                    urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
                }
            case.failure(let error):
                return .failure(error)
            }
        }

        urlComponents.queryItems = urlQueryItems.isEmpty == false ? urlQueryItems : nil

        guard let url = urlComponents.url else {
            return .failure(.urlComponetError)
        }
        return .success(url)
    }
}
