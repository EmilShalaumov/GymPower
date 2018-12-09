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
        get {
            return _weight
        }
        set {
            _weight = newValue
        }
    }
    
    var repeats: Int? {
        get {
            return _repeats
        }
        set {
            _repeats = newValue
        }
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
