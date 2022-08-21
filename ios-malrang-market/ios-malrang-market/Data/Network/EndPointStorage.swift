//
//  EndpointStorage.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import Foundation

private enum Const {
    static let basePath = "api/products"
    static let identifier = "identifier"
    static let identifierSerialNumber = UserInfomation.identifier
    static let contentType = "Content-Type"
}

enum EndPointStorage {
    case productList(pageNumber: Int, perPages: Int)
    case productDetail(id: Int)
    case productPost(body: ProductRequest)
}

extension EndPointStorage {
    var endPoint: EndPoint {
        switch self {
        case .productList(pageNumber: let pageNumber, perPages: let perPages):
            return self.productList(pageNumber: pageNumber, perPages: perPages)
        case .productDetail(id: let id):
            return self.productDetail(id: id)
        case .productPost(body: let body):
            return self.productPost(body)
        }
    }
}

extension EndPointStorage {
    private func productList(pageNumber: Int, perPages: Int) -> EndPoint {
        let queryParameters = ProductRequest(
            pageNumber: pageNumber,
            perPages: perPages
        )
        let endPoint = EndPoint(
            path: Const.basePath,
            method: .get,
            queryParameters: queryParameters
        )
        return endPoint
    }

    private func productDetail(id: Int) -> EndPoint {
        let endPoint = EndPoint(
            path: Const.basePath + "/\(id)",
            method: .get
        )
        return endPoint
    }

    private func productPost(_ body: ProductRequest) -> EndPoint {
        let headers: [String: String] = [
            Const.identifier: Const.identifierSerialNumber,
            Const.contentType: "multipart/form-data; boundary=\"\(body.boundary ?? "")\""
        ]
        let endPoint = EndPoint(
            path: Const.basePath,
            method: .post,
            bodyParameters: body,
            headers: headers
        )
        return endPoint
    }
}
