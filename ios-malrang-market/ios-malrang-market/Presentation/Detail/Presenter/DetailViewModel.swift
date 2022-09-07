//
//  DetailViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import RxRelay

protocol DetailViewModelOutput {
    var imageString: Observable<[String]> { get }
    var error: Observable<Error>? { get }
    func productInfomation() -> ProductInfomation
}

protocol DetailViewModelable: DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let product: ProductDetail
    private let useCase: Usecase
    private let productImages = BehaviorRelay<[String]>(value: [])
    var error: Observable<Error>?
    var imageString: Observable<[String]> {
        self.productImages.asObservable()
    }

    init(
        product: ProductDetail,
        useCase: Usecase
    ) {
        self.product = product
        self.useCase = useCase
        self.fetchProductImages(id: self.product.id)
    }

    func productInfomation() -> ProductInfomation {
        return ProductInfomation(
            name: self.product.name ?? "",
            createdAt: self.createdAtInfomation() ?? "",
            description: self.product.description ?? "",
            price: self.priceInfomation() ?? "",
            stock: self.stockInfomation()
        )
    }
}

extension DetailViewModel {
    private func fetchProductImages(id: Int?) {
        guard let id = id else {
            return self.error = .just(ProductError.productId)
        }

        _ = self.useCase.fetchProductImages(id: id)
            .subscribe { [weak self] images in
                let imageList = images.compactMap { $0.url }
                self?.productImages.accept(imageList)
            } onError: { [weak self] error in
                self?.error = .just(error)
            }
    }

    private func createdAtInfomation() -> String? {
        return self.product.createdAt?.date()?.formatterString()
    }

    private func priceInfomation() -> String? {
        guard let price = self.product.price?.formatterString() else {
            return ""
        }
        return "\(price)원"
    }

    private func stockInfomation() -> NSMutableAttributedString {
        guard let stock = self.product.stock?.formatterString() else {
            return NSMutableAttributedString()
        }

        let stockLabel = "현재 재고는 \(stock)개 남아있습니다."

        return NSMutableAttributedString(
            text: stockLabel,
            fontWeight: .bold,
            letter: "\(stock)개"
        )
    }
}
