//
//  HomeDetailViewController.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController {

    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        presenter.viewIsReady()
        initialize()
    }
    
    func initialize() {
        //title = Localize(key: "home_detail_title")
    }
}

// MARK: - HomeDetailViewControllerProtocol

//extension HomeDetailViewController: HomeDetailViewControllerProtocol {
//    
//}


