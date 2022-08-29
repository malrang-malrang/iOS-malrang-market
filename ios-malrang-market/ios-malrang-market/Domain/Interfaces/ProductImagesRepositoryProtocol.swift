//
//  ProductImagesRepositoryProtocol.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/29.
//

import RxSwift

protocol ProductImagesRepositoryProtocol {
    func fetch(id: Int) -> Single<[ProductImages]?>
}
