//
//  Common
//  DornaTest
//
//  Created from JGC Templates on 12/2/18.
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

extension Bundle {
    
    func dataFromResource(resource: String, type: String?) -> NSData? {
        
        let path: String? = self.path(forResource: resource, ofType: type)!
        
        if path == nil {
            return nil
        }
        
        do {
            let data: NSData? = try NSData.init(contentsOfFile: path!, options: [])
            
            if data != nil {
                return data
            }
            else {
                return nil
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    func JSONFromResource(resource: String) -> NSDictionary {
        let data: NSData? = self.dataFromResource(resource: resource, type: "json")
        return data!.toJSON()!
    }
    
}
