//
//  File.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/22.
//

import RxSwift

protocol Usecase {
    func fetchProductList(pageNumber: Int, perPages: Int) -> Single<ProductList?>
    func fetchProductDetail(id: Int) -> Single<ProductDetail?>
    func fetchProductImages(id: Int) -> Single<[ProductImages]?>
}

struct DefaultUsecase: Usecase {
    private let productListRepository: ProductListRepositoryProtocol
    private let productDetailRepository: ProductDetailRepositoryProtocol
    private let productImagesRepository: ProductImagesRepositoryProtocol

    init(
        listRepository: ProductListRepositoryProtocol,
        detailRepository: ProductDetailRepositoryProtocol,
        imagesRepository: ProductImagesRepositoryProtocol
    ) {
        self.productListRepository = listRepository
        self.productDetailRepository = detailRepository
        self.productImagesRepository = imagesRepository
    }

    func fetchProductList(pageNumber: Int, perPages: Int) -> Single<ProductList?> {
        return self.productListRepository.fetch(pageNumber: pageNumber, perPages: perPages)
    }

    func fetchProductDetail(id: Int) -> Single<ProductDetail?> {
        return self.productDetailRepository.fetch(id: id)
    }

    func fetchProductImages(id: Int) -> Single<[ProductImages]?> {
        return self.productImagesRepository.fetch(id: id)
    }
}
