//
//  GrandPrix.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class GrandPrix: Codable {

    //List
    var id: String?
    var date_begin: String?
    var date_finish: String?
    var name: String?
    var top_mobile_image_url: String?
    var circuit_flag: UIImage?
    
    //Detail
    var start_time: String?
    var end_time: String?
    var champ_name: String?
 
    //MARK: - Init
    
    init(id: String, name: String, date_begin: String, date_finish: String, top_mobile_image_url: String, circuit_flag: UIImage, start_time: String, end_time: String, champ_name: String) {
        self.id = id
        self.name = name
        self.date_begin = date_begin
        self.date_finish = date_finish
        self.top_mobile_image_url = top_mobile_image_url
        self.circuit_flag = circuit_flag
        self.start_time = start_time
        self.end_time = end_time
        self.champ_name = champ_name
    }
    
    /*
     
     if let jsonData = jsonString.data(using: .utf8)
     {
     let photoObject = try? JSONDecoder().decode(Photo.self, from: jsonData)
     }
     
     */
    
    func encode(to encoder: Encoder) throws {
        
    }

    required init(from decoder: Decoder) throws {
        
    }
}
