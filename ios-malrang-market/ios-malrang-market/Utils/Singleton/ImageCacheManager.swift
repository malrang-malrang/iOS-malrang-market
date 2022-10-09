//
//  ImageCacheManager.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/25.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()

    let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()

    private init() {}
}
