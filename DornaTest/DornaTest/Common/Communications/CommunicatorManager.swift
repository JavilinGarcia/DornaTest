//
//  CommunicatorManager.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 13/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Alamofire

class CommunicatorManager {
    
    static let sharedInstance = CommunicatorManager()
    
    // MARK: Init
    
    public init() { self.initComponents()}
    
    // MARK: - Private Methods
    
    func initComponents() {

    }
    
    // MARK: - Public Methods
    
    func getAllGrandPrixes() {
        Alamofire.request(BASE_URL).responseJSON(completionHandler: { (response) in
            if let result = response.result.value {
                if let status = response.response?.statusCode {
                    if status == 200 {
                        print(result)
                    }
                }
            }
        }) 
    }
    
    func getGrandPrixDetail(id: String) {
        
    }
}
