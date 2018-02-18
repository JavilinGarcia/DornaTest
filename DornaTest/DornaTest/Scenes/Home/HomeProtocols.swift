//
//  HomeProtocols.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

// MARK: - HomeViewControllerProtocol

protocol HomeViewControllerProtocol: LibViewControllerProtocol {
    //Properties
    var presenter: HomePresenterProtocol! { get }
    //Methods
    func reloadData(listModel: [HomeListModel])
}

// MARK: - HomeDetailViewControllerProtocol

protocol HomeDetailViewControllerProtocol: LibViewControllerProtocol {
    //Properties
    var presenter: HomePresenterProtocol! { get}
    var headerModel: HomeListModel? { get }
    var tableViewDataSource: [(key: String, value:[HomeDetailModel])]? { get }
    //Methods
    func reloadData(headerModel: HomeListModel, detailModel: [(key: String, value:[HomeDetailModel])])
}

// MARK: - HomePresenterProtocol

protocol HomePresenterProtocol: LibPresenterProtocol {
    //Properties
    var viewController: HomeViewControllerProtocol! { get }
    var detailViewController: HomeDetailViewController? { get set }
    var listDataSource: [HomeListModel]? { get }
    var detailDataSource: [(key: String, value:[HomeDetailModel])]? { get }
    //Methods
    func userDidTapRow(_ index: Int)
    func userDidPullToRefresh()
    func reloadData(models: [GrandPrix])
    func reloadDetail(model: GrandPrix)
}

// MARK: - HomeInteractorProtocol

protocol HomeInteractorProtocol: LibInteractorProtocol {
    //Properties
    var presenter: HomePresenterProtocol! { get }
    var router: HomeRouterProtocol! { get }
    var grandPrixes: [GrandPrix]? { get }
    //Methods
    func userDidTapRow(_ index: Int)
    func getDetail()
    func reloadData()
}

// MARK: - HomeRouterProtocol

protocol HomeRouterProtocol {
    //Properties
    var viewController: HomeViewController! { get }
    var presenter: HomePresenterProtocol! {get set}
    //Methods
    func navigateToDetail(_ aPresenter: HomePresenterProtocol)
}
