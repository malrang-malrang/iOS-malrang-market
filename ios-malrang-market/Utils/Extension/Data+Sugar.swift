//
//  Data+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/17.
//

import Foundation

extension Data {
    func decode<T: Decodable>() -> Result<T, Error> {
        do {
            let data = try Json.decoder.decode(T.self, from: self)
            return .success(data)
        } catch {
            return .failure(NetworkError.decodeError)
        }
    }
}
