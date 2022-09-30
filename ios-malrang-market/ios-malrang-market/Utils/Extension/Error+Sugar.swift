//
//  Error+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/30.
//

import Foundation

extension Error {
    var discription: String {
        if let networkError = self as? NetworkError {
            return networkError.errorDescription
        }

        if let inputError = self as? InputError {
            return inputError.errorDescription
        }

        return self.localizedDescription
    }
}
