//
//  Bundle+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/10/09.
//

import Foundation

extension Bundle {
    private var file: String {
        guard let file = self.path(forResource: "MalrangMarketInfo", ofType: "plist") else {
            return ""
        }
        return file
    }

    var apiKey: String {
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        guard let key = resource["API_KEY"] as? String else {
            fatalError("MalrangMarketInfo.plist에 API_KEY 설정을 해주세요.")
        }

        return key
    }

    var vendorId: Int {
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return .zero
        }
        guard let id = resource["VendorId"] as? Int else {
            fatalError("MalrangMarketInfo.plist에 VendorId 설정을 해주세요.")
        }

        return id
    }

    var secret: String {
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        guard let secret = resource["Secret"] as? String else {
            fatalError("MalrangMarketInfo.plist에 Secret 설정을 해주세요.")
        }

        return secret
    }
}
