//
//  HomeInteractor.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {
    
    var presenter: HomePresenterProtocol!
    var router: HomeRouterProtocol!
    var grandPrixes: [GrandPrix]?
    
    var currentGrandPrix: GrandPrix?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func viewIsReady() {
        
    }
    
    func userDidTapRow(_ index: Int) {
//        currentGrandPrix = grandPrixes?[index]
        router.navigateToDetail()
    }
}
