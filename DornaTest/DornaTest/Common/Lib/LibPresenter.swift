//
//  Common
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class LibPresenter: NSObject {
    
    func showLoading(loadingMessage: String, viewController: LibViewControllerProtocol!) {
        viewController.showLoading(loadingMessage: loadingMessage)
    }
    
    func dismissLoading(viewController: LibViewControllerProtocol!) {
        viewController.dismissLoading()
    }
    
    func dismissLoadingWithCompletion(viewController: LibViewControllerProtocol!, completion: @escaping() -> ()) {
        viewController.dismissLoadingWithCompletion(animated: true, completion: completion)
    }

    
    func showAlertWithTitle(title: String, message: String, viewController: LibViewControllerProtocol!) {
        viewController.showAlertWithTitle(title: title, message: message)
    }
    
    func showError(error: Error, viewController: LibViewControllerProtocol!) {
        viewController.showError(error: error)
    }
}

