//
//  Common
//  DornaTest
//
//  Created from JGC Templates on 12/2/18.
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

protocol LibPresenterProtocol {
    func viewIsReady()
    func showLoading(loadingMessage: String)
    func dismissLoading()
    func showAlertWithTitle(title: String, message: String)
}

protocol LibViewControllerProtocol {
    func showLoading(loadingMessage: String)
    func dismissLoading()
    func showAlertWithTitle(title: String, message: String)
}

protocol LibInteractorProtocol {
    func viewIsReady()
}

