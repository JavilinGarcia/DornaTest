//
//  Common
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Foundation

extension NSData {
    
    func toJSON() -> NSDictionary? {
        do {
            let json: NSDictionary? = try JSONSerialization.jsonObject(with: self as Data, options: []) as? NSDictionary
            
            if json != nil {
                return json
            }
            else {
                return nil
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}
