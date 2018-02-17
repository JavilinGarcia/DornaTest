//
//  GrandPrix.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class GrandPrix {

    var id: String?
    var date_begin: String?
    var date_finish: String?
    var name: String?
    var top_mobile_image_url: String?
    var top_mobile_image_data: Data?
    var top_mobile_image: UIImage?
    var circuit_flag: UIImage?
    var circuit_flag_data: Data?
    var sessions: [GPSession]?
 
    //MARK: - Init
    
    init(withImageData id: String, name: String, date_begin: String, date_finish: String, top_mobile_image_data: Data, circuit_flag_data: Data) {
        self.id = id
        self.name = name
        self.date_begin = date_begin
        self.date_finish = date_finish
        self.top_mobile_image_data = top_mobile_image_data
        self.top_mobile_image = UIImage(data: top_mobile_image_data)
        self.circuit_flag_data = circuit_flag_data
        self.circuit_flag = UIImage(data: circuit_flag_data)
        
        self.sessions = [GPSession]()
    }
    
}
