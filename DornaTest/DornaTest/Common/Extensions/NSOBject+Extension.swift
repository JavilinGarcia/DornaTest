//
//  Common
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Foundation

extension NSObject {
    class func classType(anyClass: AnyClass) -> NSObject.Type {
        let className = NSStringFromClass(anyClass)
        return NSClassFromString(className) as! NSObject.Type
    }
}

