//
//  DornaTestUITests.swift
//  DornaTestUITests
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import XCTest

class DornaTestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserDidTapRow() {
        let tableView = app.tables.containing(XCUIElement.ElementType.table, identifier: "gpTableViewIdentifier")
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
        //Wait for show detail result
        let _ = app.tableRows["HomeDetailTableViewCellIdentifier"].waitForExistence(timeout: 3)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        //Wait for show main tableview
        let _ = app.tableRows["gpTableViewIdentifier"].waitForExistence(timeout: 3)

    }
    
    func testUserDidPullTorefresh() {
        let tableView = app.tables.containing(XCUIElement.ElementType.table, identifier: "gpTableViewIdentifier")
        let firstCell = tableView.cells.element(boundBy: 0)
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector.init(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector.init(dx: 0, dy: 3))
            
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
