//
//  JsonDataTableViewCell.swift
//  Round3_JsonParse_RohitNikam
//
//  Created by Geekyworks on 03/09/20.
//  Copyright © 2020 Rohit Nikam. All rights reserved.
//

import UIKit

class JsonDataTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryIdLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
