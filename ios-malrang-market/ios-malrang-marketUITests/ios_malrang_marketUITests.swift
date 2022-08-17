//
//  ios_malrang_marketUITests.swift
//  ios-malrang-marketUITests
//
//  Created by 김동욱 on 2022/08/03.
//

import XCTest

class IosMalrangMarketUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            XCUIApplication().launch()
        }
    }
}
