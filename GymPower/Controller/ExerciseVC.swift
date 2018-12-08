//
//  ExerciseVC.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 17/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit

class ExerciseVC: UIViewController{
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repeatsTextField: UITextField!
    @IBOutlet weak var exerciseTextField: UILabel!
    
    var setIndex: Int = -1
    var exIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTextField.text = String(exIndex + 1) + ". " + StartService.instance.exercises[exIndex].exerciseName
        weightTextField.text = String(StartService.instance.exercises[exIndex].sets[setIndex].weight ?? -1)
        repeatsTextField.text = String(StartService.instance.exercises[exIndex].sets[setIndex].repeats ?? -1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        setIndex += 1
        //exIndex += 1
        print(String(StartService.instance.exercises[exIndex].sets.count) + " " + String(setIndex))
        //print(StartService.instance.exercises[exIndex].sets[setIndex].weight ?? -1)
        //print(StartService.instance.exercises[exIndex].sets[setIndex].repeats ?? -1)
        //test pool commit
        
        if StartService.instance.exercises[exIndex].sets.count > setIndex {
            StartService.instance.currSet = setIndex
            setFields()
            UIView.setAnimationsEnabled(false)
            self.performSegue(withIdentifier: "showRestVC", sender: nil)
        } else if StartService.instance.exercises.count > (exIndex + 1) {
            exIndex += 1
            setIndex = 0
            StartService.instance.currSet = 0
            StartService.instance.currExercise = exIndex
            exerciseTextField.text = String(exIndex + 1) + ". " + StartService.instance.exercises[exIndex].exerciseName
            setFields()
            self.performSegue(withIdentifier: "showRestVC", sender: nil)
        } else {
            StartService.instance.currSet = -1
            StartService.instance.currExercise = -1
            self.dismiss(animated: true, completion: nil)
        }
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    func setFields() {
        weightTextField.text = String(StartService.instance.exercises[exIndex].sets[setIndex].weight ?? -1)
        repeatsTextField.text = String(StartService.instance.exercises[exIndex].sets[setIndex].repeats ?? -1)
    }
    
}
