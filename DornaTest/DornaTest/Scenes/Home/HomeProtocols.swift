//
//  HomeProtocols.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

protocol HomeViewControllerProtocol: LibViewControllerProtocol {
    var presenter: HomePresenterProtocol! { get }
    var dataSource: [HomeListModel]? { get }
}

protocol HomeDetailViewControllerProtocol: LibViewControllerProtocol {
    var presenter: HomePresenterProtocol! { get}
    var dataSource: [HomeDetailModel]? { get }
}

protocol HomePresenterProtocol: LibPresenterProtocol {
    var viewController: HomeViewControllerProtocol! { get }
    var detailViewController: HomeDetailViewController! { get set }

    var listDataSource: [HomeListModel]? { get }
    var detailDataSource: [HomeDetailModel]? { get }
    
    func userDidTapRow(_ index: Int)
}

protocol HomeInteractorProtocol: LibInteractorProtocol {
    var presenter: HomePresenterProtocol! { get }
    var router: HomeRouterProtocol! { get }
    var grandPrixes: [GrandPrix]? { get }
    
    func userDidTapRow(_ index: Int)
}

protocol HomeRouterProtocol {
    var viewController: HomeViewController! { get }
    var presenter: HomePresenterProtocol! {get set}

    func navigateToDetail()
}
