//
//  DetailViewModel.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/08/25.
//

import RxCocoa
import RxSwift
import RxRelay

protocol DetailViewModelInput {
    func didTapBackBarButton()
}

protocol DetailViewModelOutput {
    var productImages: BehaviorRelay<[UIImage]> { get }
    func productInfomation() -> ProductInfomation
}

protocol DetailViewModelable: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let product: ProductDetail
    private let useCase: Usecase
    private let coordinator: DetailViewCoordinatorProtocol
    let productImages = BehaviorRelay<[UIImage]>(value: [])

    init(
        product: ProductDetail,
        useCase: Usecase,
        coordinator: DetailViewCoordinatorProtocol
    ) {
        print(product)
        self.product = product
        self.useCase = useCase
        self.coordinator = coordinator
        self.fetchProductImages(id: self.product.id)
    }

    func didTapBackBarButton() {
        self.coordinator.popDetailView()
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
            return print("상품 아이디가 잘못 되었습니다.")
        }

        _ = self.useCase.fetchProductImages(id: id)
            .subscribe { [weak self] images in
                let imageList = images.compactMap { $0.url?.image() }
                self?.productImages.accept(imageList)
            } onError: { error in
                print(error)
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

private extension String {
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
