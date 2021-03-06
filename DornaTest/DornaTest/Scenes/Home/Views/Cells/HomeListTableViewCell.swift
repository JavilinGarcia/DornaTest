//
//  HomeListTableViewCell.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

public let cellId = "HomeListTableViewCellIdentifier"

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var gpNameLabel: UILabel!
    @IBOutlet weak var gpDayLabel: UILabel!
    @IBOutlet weak var gpMonthLabel: UILabel!
    @IBOutlet weak var gpFlagImageView: UIImageView!
    @IBOutlet weak var gpBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    class func getHeight() -> CGFloat {
        return 100.0
    }
    
    class func getCellIdentifier() -> String {
        return cellId
    }
}
