//
//  ViewController.swift
//  TipCalculator
//
//  Created by Krishna Alex on 2/9/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billText: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var setSplitNumStepper: UIStepper!
    @IBOutlet weak var splitNumLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
       
        let defaults = UserDefaults.standard
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
        self.tipControl.selectedSegmentIndex = tipValueIndex
    
        billText.becomeFirstResponder()
            //keyboard is always visible and the bill amount is always the first responder

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func setSplitValue(_ sender: Any) {
        let splitNum = setSplitNumStepper.value;
        splitNumLabel.text = String(Int(splitNum))
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billText.text!) ?? 0
        let spltNum = setSplitNumStepper.value
        let spltBill = bill / spltNum
        
        let tip = spltBill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = spltBill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

