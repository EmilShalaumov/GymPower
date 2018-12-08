//
//  HeaderView.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 16/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    override func awakeFromNib() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
        layer.zPosition = 1
    }

}
