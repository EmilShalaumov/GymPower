//
//  Exercise.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 02/12/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import Foundation

struct Exercise {
    fileprivate var _exerciseName: String
    fileprivate var _sets: [ExerciseSet]
    
    var exerciseName: String {
        return _exerciseName
    }
    
    var sets: [ExerciseSet] {
        return _sets
    }
    
    init(exerciseName: String, sets: [ExerciseSet]) {
        _exerciseName = exerciseName
        _sets = sets
    }
    
    init(exerciseName: String, sets: Dictionary<String, Any>) {
        _exerciseName = exerciseName
        _sets = []
        let sortedSets = sets.sorted(by: {$0.0 < $1.0})
        for (_, set) in sortedSets {
            let oneset = set as! Dictionary<String, Any>
            _sets.append(ExerciseSet(weight: (oneset["weight"] as! Int), repeats: (oneset["repeats"] as! Int)))
        }
    }
}

/*
 let sets = exerciseName["sets"] as! Dictionary<String, AnyObject>
 for (_, obj) in sets {
 print(String(obj["weight"] as! Int) + " ")
 */
