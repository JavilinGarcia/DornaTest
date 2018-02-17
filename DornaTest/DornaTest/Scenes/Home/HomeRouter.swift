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
    
    func navigateToDetail(_ aPresenter: HomePresenterProtocol) {
        let homeDetailViewController: HomeDetailViewController = HomeDetailViewController()
        presenter.detailViewController = homeDetailViewController
        homeDetailViewController.presenter = aPresenter
        viewController.navigationController?.pushViewController(homeDetailViewController, animated: true)
    }
    
//    func navigateToDetail(selectedGP: GrandPrix) {
//        let homeDetailViewController: HomeDetailViewController = HomeDetailViewController()
//        presenter.detailViewController = homeDetailViewController
//        homeDetailViewController.presenter = presenter
//        homeDetailViewController.currentGP = selectedGP
//        viewController.navigationController?.pushViewController(homeDetailViewController, animated: true)
//    }
}
