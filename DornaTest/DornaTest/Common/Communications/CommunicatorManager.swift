//
//  CommunicatorManager.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 13/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Alamofire

protocol GrandPrixesRequestDelegate {
    func didGetAllGrandPrixesResponse(response: DataResponse<Any>)
    func didGetGrandPrixDetailResponse(response: DataResponse<Any>)
}

class CommunicatorManager {
    
    static let sharedInstance = CommunicatorManager()
    
    // MARK: Init
    public init() { self.initComponents()}
    
    // MARK: - Private Methods
    func initComponents() {
    }
    
    // MARK: - Public Methods
    func getAllGrandPrixes(delegate: GrandPrixesRequestDelegate) {
        Alamofire.request(BASE_URL).responseJSON(completionHandler: { (response) in
            delegate.didGetAllGrandPrixesResponse(response: response)
        })
    }
    
    func getGrandPrixDetail(id: String, delegate: GrandPrixesRequestDelegate) {
        Alamofire.request(BASE_URL+id).responseJSON(completionHandler: { (response) in
            delegate.didGetGrandPrixDetailResponse(response: response)
        })
    }
}
