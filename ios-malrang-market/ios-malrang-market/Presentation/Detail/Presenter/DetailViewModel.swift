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
    var productImages: BehaviorRelay<[UIImage]?> { get }
}

protocol DetailViewModelable: DetailViewModelInput, DetailViewModelOutput {}

final class DetailViewModel: DetailViewModelable {
    private let product: ProductDetail
    private let useCase: Usecase
    private let coordinator: DetailViewCoordinatorProtocol
    let productImages = BehaviorRelay<[UIImage]?>(value: [])

    init(
        product: ProductDetail,
        useCase: Usecase,
        coordinator: DetailViewCoordinatorProtocol
    ) {
        self.product = product
        self.useCase = useCase
        self.coordinator = coordinator
        self.fetchProductImages(id: self.product.id)
    }

    private func fetchProductImages(id: Int?) {
        guard let id = id else {
            return print("상품 아이디가 잘못 되었습니다.")
        }

        _ = self.useCase.fetchProductImages(id: id)
            .subscribe { [weak self] images in
                let imageList = images?.compactMap { $0.url?.image() }
                self?.productImages.accept(imageList)
            } onFailure: { error in
                print(error)
            }
    }

    func didTapBackBarButton() {
        self.coordinator.popDetailView()
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
