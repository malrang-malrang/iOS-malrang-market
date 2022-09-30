//
//  NetworkProviderTest.swift
//  ios-malrang-marketTests
//
//  Created by 김동욱 on 2022/08/17.
//

import XCTest
@testable import ios_malrang_market

class NetworkProviderTest: XCTestCase {
    var sut: NetworkProvider!

    override func setUpWithError() throws {
        let session = self.makeMockUrlSession()
        self.sut = NetworkProvider(urlSession: session)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_네트워크가_연결이_되지않아도_request를_호출할때_예상값을_반환한다() {
        // given
        let promise = expectation(description: "Test Request")
        self.makeResult()
        let endPoint = EndPoint(baseURL: "Test")

        // when
        _ = self.sut.request(endPoint: endPoint)
            .decode(type: ProductCatalogDTO.self, decoder: Json.decoder)
            .subscribe { productList in
                let result = productList.itemsPerPage
                let expected = 20
                XCTAssertEqual(expected, result)
                promise.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
                promise.fulfill()
            }
        wait(for: [promise], timeout: 10)
    }

    func test_네트워크가_연결이_되지않아도_requestMultiPartFormData를_호출할때_예상값을_반환한다() {
        // given
        let promise = expectation(description: "Test Request")
        self.makeMultipartFormResult()
        let endPoint = EndPoint(baseURL: "Test")

        // when
        _ = self.sut.requestMultiPartFormData(endPoint: endPoint)
            .subscribe { _ in
                XCTAssertTrue(true)
                promise.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
                promise.fulfill()
            }
        wait(for: [promise], timeout: 10)
    }
}

extension NetworkProviderTest {
    private func makeMockUrlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    private func makeResult() {
        MockURLProtocol.requestHandler = { _ in
            let httpResponse = HTTPURLResponse()
            let data = NSDataAsset(name: "products")!.data
            return (httpResponse, data)
        }
    }

    private func makeMultipartFormResult() {
        MockURLProtocol.requestHandler = { _ in
            let httpResponse = HTTPURLResponse()
            let data = Data()
            return (httpResponse, data)
        }
    }
}
