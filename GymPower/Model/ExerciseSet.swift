//
//  ExerciseSet.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 02/12/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import Foundation

struct ExerciseSet {
    fileprivate var _weight: Int?
    fileprivate var _repeats: Int?
    
    var weight: Int? {
        return _weight
    }
    
    var repeats: Int? {
        return _repeats
    }
    
    init(weight: Int?, repeats: Int?) {
        _weight = weight
        _repeats = repeats
    }
    
    init(data: Dictionary<String, Any>) {
        if let weight = data["weight"] as? Int {
            _weight = weight
        }
        
        if let repeats = data["repeats"] as? Int {
            _repeats = repeats
        }
    }
}
