//
//  HomeDetailTableViewCell.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 17/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var prixLabel: UILabel!
    @IBOutlet weak var satatePrixLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func getHeight() -> CGFloat {
        return 60.0
    }
    
    class func getCellIdentifier() -> String {
        return "HomeDetailTableViewCellIdentifier"
    }
}
