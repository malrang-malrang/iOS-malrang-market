//
//  ios_malrang_marketUITestsLaunchTests.swift
//  ios-malrang-marketUITests
//
//  Created by 김동욱 on 2022/08/03.
//

import XCTest

class IosMalrangMarketUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
