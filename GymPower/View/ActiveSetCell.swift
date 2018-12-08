//
//  ActiveSetCell.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 17/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit

class ActiveSetCell: UITableViewCell {
    
    @IBOutlet weak var repeatsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
