//
//  HomeProtocols.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

protocol HomeViewControllerProtocol: LibViewControllerProtocol {
    var presenter: HomePresenterProtocol! { get }
}

protocol HomePresenterProtocol: UITextFieldDelegate, LibPresenterProtocol {
    var viewController: HomeViewControllerProtocol! { get }
}

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol! { get }
    var router: HomeRouterProtocol! { get }
}

protocol HomeRouterProtocol {
    var viewController: HomeViewController! { get }
}
