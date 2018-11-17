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
                    let dayName = snap.value as! String
                    self.days.append((dayId: snap.key, dayName: dayName))
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
            self.performSegue(withIdentifier: "showExerciseVC", sender: nil)
        }
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

