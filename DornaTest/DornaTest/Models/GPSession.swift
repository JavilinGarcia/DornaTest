//
//  GPSession.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 14/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class GPSession {

    var gpID: String?
    var sessionID: String?
    var start_time: String?
    var end_time: String?
    var champ_name: String?
    var name: String?

    //MARK: - Init
    
    init(gpID: String, sessionID: String, start_time: String, end_time: String, champ_name: String, name: String) {
        self.gpID = gpID
        self.sessionID = sessionID
        self.start_time = start_time
        self.end_time = end_time
        self.champ_name = champ_name
        self.name = name
    }
    
}
