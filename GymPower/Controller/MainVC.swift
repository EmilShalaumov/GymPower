//
//  MainVC.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 16/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var trainingDaysPicker: UIPickerView!
    
    var days: [(dayId: String, dayName: String)] = []
    var dbUserName = AuthService.instance.username?.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
    let dateFormat = DateFormatter()
    let ref = Database.database().reference()
    var checkDigit = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.trainingDaysPicker.delegate = self
        self.trainingDaysPicker.dataSource = self
        
        //Datetime format
        dateFormat.timeZone = TimeZone.current
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let userName = dbUserName {
            let userRef = ref.child(userName)
            userRef.child("weight").observeSingleEvent(of: .value, with: { (snapshot) in
                if let weight = snapshot.value as? Int {
                    self.weightTextField.text = "\(weight)"
                }
            })
            
            userRef.child("program").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let dayName = snap.value as! Dictionary<String, AnyObject>
                    self.days.append((dayId: snap.key, dayName: dayName["name"] as! String))
                }
                self.trainingDaysPicker.reloadAllComponents()
            })
        }
        
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "showSignInVC", sender: nil)
        } catch {
            print("An error occured signing out")
        }
    }
    
    @IBAction func startTrainingButtonTapped(_ sender: Any) {
        if let userName = dbUserName {
            let userRef = ref.child(userName)
            userRef.child("trainings").childByAutoId().setValue(["weight": weightTextField.text ?? "Null", "timestamp": dateFormat.string(from: Date()), "dayId": String(days[trainingDaysPicker.selectedRow(inComponent: 0)].dayId)])
            print(days[trainingDaysPicker.selectedRow(inComponent: 0)].dayId)
            /*userRef.child("program/\(days[trainingDaysPicker.selectedRow(inComponent: 0)].dayId)/exercises").observeSingleEvent(of: .value, with: { (snapshot) in
                    for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let exerciseName = snap.value as! Dictionary<String, AnyObject>
                    print(snap.key + " " + (exerciseName["name"] as! String))
                    let sets = exerciseName["sets"] as! Dictionary<String, AnyObject>
                    for (_, obj) in sets {
                        print(String(obj["weight"] as! Int) + " ")
                    }
                }
            })*/
            StartService.instance = StartService()
            StartService.instance.loadExercises(username: userName, dayId: days[trainingDaysPicker.selectedRow(inComponent: 0)].dayId, {Success in
                if !Success {
                    print("Load Firebase data FAILED!")
                } else {
                    print("Success!")
                    for oneex in StartService.instance.exercises {
                        print(oneex.exerciseName)
                        for oneset in oneex.sets {
                            print(oneset.weight ?? "a")
                            print(oneset.repeats ?? "b")
                        }
                        /*let vc = ExerciseVC(nibName: "showExerciseVC", bundle: nil)
                        vc.exIndex = 0
                        vc.setIndex = 0
                        self.navigationController?.pushViewController(vc, animated: true)*/
                        StartService.instance.currExercise = 0
                        StartService.instance.currSet = 0
                        self.performSegue(withIdentifier: "showExerciseVC", sender: nil)
                    }
            }
        })
            
            /*checkDigit += 1
            if checkDigit % 2 != 0 {
                self.performSegue(withIdentifier: "showExerciseVC", sender: nil)
            }*/
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExerciseVC" {
            let exerciseVC = segue.destination as! ExerciseVC
            exerciseVC.exIndex = StartService.instance.currExercise
            exerciseVC.setIndex = StartService.instance.currSet
        }
    }
    
    func startTraining() {
        self.performSegue(withIdentifier: "showExerciseVC", sender: nil)
    }
    
    @IBAction func decreaseWeightButtonTapped(_ sender: Any) {
        let fWeight = weightTextField.text
        if let uWeight = Double(fWeight!) {
            weightTextField.text = String(format:"%.1f", uWeight - 0.1)
        }
    }
    
    @IBAction func increaseWeightButtonTapped(_ sender: Any) {
        let fWeight = weightTextField.text
        if let uWeight = Double(fWeight!) {
            weightTextField.text = String(format:"%.1f", uWeight + 0.1)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row].dayName
    }
}

