//
//  RestVC.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 08/12/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit

class RestVC: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    var seconds = 120
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(RestVC.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)" //This will update the label.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
