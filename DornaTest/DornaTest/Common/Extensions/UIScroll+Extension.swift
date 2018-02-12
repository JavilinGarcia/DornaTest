//
//  Common
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width)
    }
    
    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    // MARK: - Notifications
    
    @objc func keyBoardWillShow(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.cgRectValue.size
        
        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
        
        contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        UIView.animate(withDuration: 0.3) {
            self.contentInset = contentInsets
            self.scrollIndicatorInsets = contentInsets
        }
    }
}

