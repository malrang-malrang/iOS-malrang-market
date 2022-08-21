//
//  Encodable+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/21.
//

import Foundation

extension Encodable {
    func toDictionary() -> Result<[String: Any], NetworkError> {
        do {
            let data = try Json.encoder.encode(self)
            guard let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return .failure(.decodeError)
            }
            return .success(jsonData)
        } catch {
            return .failure(.decodeError)
        }
    }
}
