//
//  LibViewcontroller
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
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
        self.loadingView = nil
        dismiss(animated: true, completion: nil)
    }
    
    func dismissLoadingWithCompletion(animated: Bool?, completion: @escaping() -> ()) {
        super.dismiss(animated: animated ?? true) {
            completion()
        }
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
        else {
            self.alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            
            self.alertController!.addAction(okAction)
            self.present(self.alertController!, animated: true, completion: nil)
        }
    }
    
    func showError(error: Error) {
        let alert_controller = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let ok_action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        
        alert_controller.addAction(ok_action)
        
        present(alert_controller, animated: true, completion: nil)
    }
}

