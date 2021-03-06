//
//  LibProtocols
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

protocol LibPresenterProtocol {
    func viewIsReady()
    func showLoading(loadingMessage: String)
    func dismissLoading()
    func dismissLoadingWithCompletion(animated: Bool?, completion: @escaping() -> ())
    func showAlertWithTitle(title: String, message: String)
}

protocol LibViewControllerProtocol {
    func showLoading(loadingMessage: String)
    func dismissLoading()
    func dismissLoadingWithCompletion(animated: Bool?, completion: @escaping() -> ())
    func showAlertWithTitle(title: String, message: String)
    func showError(error: Error)
}

protocol LibInteractorProtocol {
    func viewIsReady()
}

