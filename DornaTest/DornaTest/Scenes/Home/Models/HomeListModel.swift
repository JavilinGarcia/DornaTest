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
    var day_begin: String?
    var month_begin: String?
    var allDays: String?
    var name: String?
    var backgroundImage: UIImage?
    var circuit_flag: UIImage?
    
    //MARK: - Init
    init(id: String, day_begin: String, month_begin: String, allDays: String, name: String, backgroundImage: UIImage, circuit_flag: UIImage) {
        self.id = id
        self.day_begin = day_begin
        self.month_begin = month_begin
        self.allDays = allDays
        self.name = name
        self.circuit_flag = circuit_flag
        
        self.backgroundImage = backgroundImage
    }
}
