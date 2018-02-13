//
//  HomeRouter.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeRouter: NSObject {
    var viewController: HomeViewController!
    var presenter: HomePresenterProtocol!

}

extension HomeRouter: HomeRouterProtocol {    
    
    func navigateToDetail() {
        let homeDetailViewController: HomeDetailViewController = HomeDetailViewController()
        presenter.detailViewController = homeDetailViewController
        homeDetailViewController.presenter = presenter
        viewController.navigationController?.pushViewController(homeDetailViewController, animated: true)
    }
}
