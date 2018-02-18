//
//  HomeInteractor.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit
import Alamofire

class HomeInteractor: NSObject {
    
    var presenter: HomePresenterProtocol!
    var router: HomeRouterProtocol!
    var grandPrixes: [GrandPrix]?
    var currentGrandPrix: GrandPrix?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func viewIsReady() {
        presenter.showLoading(loadingMessage: Localize(key: "loading_text"))
        DataManager.sharedInstance.getAllGrandPrixes(delegate: self)
    }
    
    func userDidTapRow(_ index: Int) {
        currentGrandPrix = grandPrixes?[index]
        presenter.showLoading(loadingMessage: Localize(key: "loading_text"))
        DataManager.sharedInstance.getGrandPrixDetail(gpID: (currentGrandPrix?.id)!, delegate: self)
    }
    
    func getDetail() {
        presenter.reloadDetail(model: currentGrandPrix!)
    }
    
    func reloadData() {
        presenter.showLoading(loadingMessage: Localize(key: "loading_text"))
        DataManager.sharedInstance.reloadData(delegate: self)
    }
}

extension HomeInteractor: GrandPrixesDelegate {
    
    func didGetAllGrandPrixes(prixes: [GrandPrix]) {
        presenter.dismissLoading()
        if prixes.count == 0 {
            presenter.showAlertWithTitle(title: Localize(key: "error_title"), message: Localize(key: "error_default_msg"))
        }
        else {
            grandPrixes = nil
            grandPrixes = prixes
            presenter.reloadData(models: prixes)
        }
    }
    
    func didGetGrandPrixDetail(gpSessions: [GPSession]) {
        
        if gpSessions.count == 0 {
            presenter.dismissLoading()
            presenter.showAlertWithTitle(title: Localize(key: "error_title"), message: Localize(key: "error_default_msg"))
        }
        else {
            currentGrandPrix?.sessions = gpSessions

            presenter.dismissLoadingWithCompletion(animated:true, completion: {
                self.router.navigateToDetail(self.presenter)
            })
        }
    }
}

