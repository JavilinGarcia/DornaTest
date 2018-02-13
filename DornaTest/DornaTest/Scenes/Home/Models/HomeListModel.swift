//
//  HomeListModel.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 13/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

struct HomeListModel {

    var id: String?
    var date_begin: String?
    var date_finish: String?
    var name: String?
    var top_mobile_image_url: String?
    var circuit_flag: UIImage?
    
    //MARK: - Init
    init(id: String, date_begin: String, date_finish: String, name: String, top_mobile_image_url: String, circuit_flag: UIImage) {
        self.id = id
        self.date_begin = date_begin
        self.date_finish = date_finish
        self.name = name
        self.top_mobile_image_url = top_mobile_image_url
        self.circuit_flag = circuit_flag
    }
    
}
