//
//  String+Sugar.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import UIKit

extension String {
    func date() -> Date? {
        Formatter.date.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        return Formatter.date.date(from: self)
    }
}

extension String {
    func image() -> UIImage {
        guard let url = URL(string: self) else {
            return UIImage()
        }

        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }

        guard let image = UIImage(data: data) else {
            return UIImage()
        }

        return image
    }
}
