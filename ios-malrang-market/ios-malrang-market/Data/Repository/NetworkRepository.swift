//
//  NetworkRepository.swift
//  ios-malrang-marketTests
//
//  Created by 김동욱 on 2022/08/18.
//

import Foundation

//네트워크에서 받아온 데이터 모델을 내가쓸 모델로 변경(UI에 반영 해주기위함) 여기서 디코드 해야함
final class NetworkRepository: Repositoryable {
    private let network: Provider = NetworkProvider()

//    func get<T: Decodable>(endPoint: Endpoint) -> Result<T, NetworkError> {
//        self.network.fetchData(from: endPoint) { result in
//            <#code#>
//        }
//    }
}
