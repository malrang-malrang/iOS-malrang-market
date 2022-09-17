////
////  MockURLSessionTest.swift
////  ios-malrang-marketTests
////
////  Created by 김동욱 on 2022/08/17.
////
//
//import XCTest
//@testable import ios_malrang_market
//
//class MockURLSessionTest: XCTestCase {
//    var sut: MalrangMarketRepository!
//
//    override func setUpWithError() throws {
//        let session = MockURLSession(isRequestSuccess: true)
//        let provider = NetworkProvider(urlSession: session)
//        self.sut = MalrangMarketRepository(networkProvider: provider)
//    }
//
//    override func tearDownWithError() throws {
//        self.sut = nil
//    }
//
//    func test_네트워크가_연결이_되지않아도_fetchData_함수를_호출하면_Mock데이터의_itemspPerPage의_값이_20인지() {
//        // given
//        let promise = expectation(description: "The Value of items per page 20")
//
//        // when
//        let endPoint = EndPoint(baseURL: , path: "api/products", method: .get)
//        _ = self.sut.fetch(endPoint: endPoint)
//            .subscribe { data in
//                XCTAssertEqual(data.itemsPerPage, 20)
//            } onFailure: { error in
//                XCTFail(error.localizedDescription)
//            }
//
//
//        self.sut.fetchProductList(from: .healthChecker) { (result: Result<ProductList, Error>) in
//
//            // then
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data.itemsPerPage, 20)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 10)
//    }
//
//    func test_네트워크가_연결이_되지않아도_fetchData_함수를_호출하면_Mock데이터의_totalCount의_값이_10인지() {
//        // given
//        let promise = expectation(description: "The value of the totalCount is 10")
//
//        // when
//        self.sut.fetchProductList(from: .healthChecker) { (result: Result<ProductList, Error>) in
//
//            // then
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data.totalCount, 10)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 10)
//    }
//
//    func test_네트워크가_연결이_되지않아도_fetchData_함수를_호출하면_Mock데이터의_pages의_첫번째값의_id값이_20인지() {
//        // given
//        let promise = expectation(description: "The first value of pages is 20")
//
//        // when
//        self.sut.fetchProductList(from: .healthChecker) { (result: Result<ProductList, Error>) in
//
//            // then
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data.pages?.first?.id, 20)
//            case .failure(let error):
//                XCTFail(error.localizedDescription)
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 10)
//    }
//
//    func test_isRequestSuccess가_false라면_fetchData_함수를호출하면_statusCode_Error인지() {
//        // given
//        let promise = expectation(description: "statusCodeError if isRequestSuccess value is false")
//        let session = MockURLSession(isRequestSuccess: false)
//        let provider = NetworkProvider(urlSession: session)
//        self.sut = ProductListRepository(networkProvider: provider)
//
//        // when
//        self.sut.fetchProductList(from: .healthChecker) { (result: Result<ProductList, Error>) in
//
//            // then
//            if case .failure(let error) = result {
//                let expected = NetworkError.statusCodeError(statusCode: 400)
//                let statusCodeError = (error as? NetworkError)
//                XCTAssertEqual(expected, statusCodeError)
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 10)
//    }
//}
