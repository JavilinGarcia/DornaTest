//
//  HomeDetailModel.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 13/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

struct HomeDetailModel {
    
    var start_time: String?
    var end_time: String?
    var champ_name: String?
 
    //MARK: - Init
    init(start_time: String, end_time: String, champ_name: String) {
        self.start_time = start_time
        self.end_time = end_time
        self.champ_name = champ_name
    }
    
}
