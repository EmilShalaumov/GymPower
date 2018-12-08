//
//  StartService.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 02/12/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import Foundation
import Firebase

class StartService {
    static var instance = StartService()
    
    let ref = Database.database().reference()
    var exercises: [Exercise] = []
    var currExercise: Int = -1
    var currSet: Int = -1
    
    func loadExercises(username: String, dayId: String, _ completion: @escaping(_ Success: Bool) -> Void) {
        ref.child("\(username)/program/\(dayId)/exercises").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let exercise = snap.value as! Dictionary<String, AnyObject>
                let oneExercise = Exercise(exerciseName: (exercise["name"] as! String), sets: exercise["sets"] as! Dictionary<String, Any>)
                self.exercises.append(oneExercise)
            }
            completion(true)
        })
    }
}

/*
 userRef.child("program/\(days[trainingDaysPicker.selectedRow(inComponent: 0)].dayId)/exercises").observeSingleEvent(of: .value, with: { (snapshot) in
 for child in snapshot.children {
 let snap = child as! DataSnapshot
 let exerciseName = snap.value as! Dictionary<String, AnyObject>
 print(snap.key + " " + (exerciseName["name"] as! String))
 let sets = exerciseName["sets"] as! Dictionary<String, AnyObject>
 for (_, obj) in sets {
 print(String(obj["weight"] as! Int) + " ")
 }
 }
 })
*/
