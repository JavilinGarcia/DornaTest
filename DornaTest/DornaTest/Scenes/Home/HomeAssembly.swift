//
//  HomeAssembly.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//


import UIKit

class HomeAssembly: NSObject {
    
    static let sharedInstance = HomeAssembly()
    
    func configure() -> UIViewController {
        let viewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.presenter = presenter
        
        presenter.viewController = viewController
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.router = router
        
        router.viewController = viewController
        
        return viewController
    }
    
}
