//
//  DornaTestTests.swift
//  DornaTestTests
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import XCTest
@testable import DornaTest

class DornaTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_1_SaveToLocal() {
        let dataFlag:Data?
        let dataTop:Data?
        
        let flagImage:UIImage = UIImage(named: "defaultFlag")!
        dataFlag = UIImagePNGRepresentation(flagImage)
        
        let image:UIImage = UIImage(named: "defaultCellBackground")!
        dataTop = UIImageJPEGRepresentation(image, 1)
        
        let gp: GrandPrix = GrandPrix.init(withImageData: "1001", name: "gp", date_begin: "2017-11-14T00:00:00+01:00", date_finish: "2017-11-15T00:00:00+01:00", top_mobile_image_data: dataTop!, circuit_flag_data: dataFlag!)
        
        DataManager.sharedInstance.saveGrandPrixesIntoCoreData(prixes: [gp]) { (result) in
            XCTAssertTrue(result)
        }
    }
    
    func test_2_GetAllDataFromLocal() {
        DataManager.sharedInstance.getFromLocal { (result) in
            XCTAssertTrue(result.count > 0)
        }
    }
    
    func test_3_DeleteAllDataFromLocal() {
        DataManager.sharedInstance.deleteAllEntities { (success) in
            XCTAssertTrue(success)
        }
    }
    
}

