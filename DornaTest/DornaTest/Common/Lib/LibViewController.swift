//
//  Common
//  DornaTest
//
//  Created from JGC Templates on 12/2/18.
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//


import UIKit

class LibViewController: UIViewController {
    
    var loadingView: UIAlertController?
    var alertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

extension LibViewController: LibViewControllerProtocol {
    
    func showLoading(loadingMessage: String) {
        
        loadingView = UIAlertController(title: nil, message: loadingMessage, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        loadingView!.view.addSubview(loadingIndicator)
        present(loadingView!, animated: true, completion: nil)
    }
    
    func dismissLoading() {
        dismiss(animated: true, completion: nil)
        loadingView = nil
    }
    
    func showAlertWithTitle(title: String, message: String) {
        if loadingView != nil {
            dismiss(animated: true, completion: {
                self.alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                
                self.alertController!.addAction(okAction)
                self.present(self.alertController!, animated: true, completion: nil)
            })
        }
    }
    
}

