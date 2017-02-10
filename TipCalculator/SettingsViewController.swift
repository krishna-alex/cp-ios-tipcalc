//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Krishna Alex on 2/9/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaltTipControl: UISegmentedControl!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tipValue =
            defaults.float(forKey: "defaultTip")
        var tipValueIndex = 0
        
        switch tipValue {
        case 0.18:
            tipValueIndex = 0
        case 0.2:
            tipValueIndex = 1
        case 0.25:
            tipValueIndex = 2
        default:
            tipValueIndex = 0
        }
        
        self.defaltTipControl.selectedSegmentIndex = tipValueIndex
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     @IBAction func defaultTipSelection(_ sender: Any) {
     }
    */
    
   
    @IBAction func setDefaultTip(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let selectedTipValue = tipPercentages[defaltTipControl.selectedSegmentIndex]
        defaults.set(selectedTipValue, forKey: "defaultTip")
        defaults.synchronize()
        
    }
    

}
