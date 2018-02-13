//
//  HomePresenter.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomePresenter: LibPresenter {
    
    var viewController: HomeViewControllerProtocol!
    var interactor: HomeInteractorProtocol!
    var detailViewController: HomeDetailViewController!

    var listDataSource: [HomeListModel]?
    var detailDataSource: [HomeDetailModel]?
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewIsReady() {
        interactor.viewIsReady()
    }
    
    func userDidTapRow(_ index: Int) {
        interactor.userDidTapRow(index)
    }
    
    //COMMON
    
    func showLoading(loadingMessage: String) {
        super.showLoading(loadingMessage: loadingMessage, viewController: viewController)
    }
    
    func dismissLoading() {
        super.dismissLoading(viewController: viewController)
    }
    
    func showError(error: Error) {
        super.showError(error: error, viewController: viewController)
    }
    
    func showAlertWithTitle(title: String, message: String) {
        viewController.showAlertWithTitle(title: title, message: message)
    }
    
}
