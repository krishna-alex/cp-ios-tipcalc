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
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet var mainView: UIView!
    
    let defaults = UserDefaults.standard
    
 
    func formatInLocalCurrency(amount: Double) -> (String)
    {
        // function to set the locale specific currency
    let _currencyFormatter : NumberFormatter = NumberFormatter()
    _currencyFormatter.numberStyle = NumberFormatter.Style.currency
    _currencyFormatter.locale = NSLocale.current
    return(_currencyFormatter.string(from: NSNumber.init(value: amount)))!
        
    }
    
    func tipPercentile()
    {
        //functin to set the tip percentage
        
        let tipValue = defaults.float(forKey: "defaultTip")
        
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
        
    }
    
    func calcTip()
    {
        // function to calculate tip and total amount
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billText.text!) ?? 0
        let spltNum = setSplitNumStepper.value
        let spltBill = bill / spltNum
        
        let tip = spltBill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = spltBill + tip
        
        tipLabel.text = formatInLocalCurrency(amount: tip)
        totalLabel.text = formatInLocalCurrency(amount: total)
    }
    
    func resumeState()
    {
        //Remember the bill amount across app restarts. After an extended period of time(10min), clear the state.
        
        let resumeTime = NSDate()
        print( "resumeTime \(resumeTime)")
       
        if let prevTime = defaults.value(forKey: "TimeStamp")
        {
            let interval = Int(resumeTime.timeIntervalSince(prevTime as! Date))
            print( "interval \(interval)")

            if interval > 600
            {
                billText.text=""
                resultView.alpha = 0
                
            }
        }
    }
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = StyleTheme.Theme.loadTheme().bgcolor
        resultView.backgroundColor = StyleTheme.Theme.loadTheme().fgcolor
        
        billText.placeholder = formatInLocalCurrency(amount: 0)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.resumeState), name:
        NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        //Remember the bill amount across app restarts. After an extended period of time(10min), clear the state.
        
        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 0.24, green: 0.27, blue: 0.36, alpha: 1.0)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        
        
        tipPercentile()
    
        billText.becomeFirstResponder()
            //keyboard is always visible and the bill amount is always the first responder
        self.mainView.alpha = 0
        self.resultView.alpha = 1
        UIView.animate(withDuration: 0.4, animations: {
            self.mainView.alpha = 1
            self.resultView.alpha = 0
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
        super.viewDidAppear(animated);
        mainView.backgroundColor = StyleTheme.Theme.loadTheme().bgcolor
        resultView.backgroundColor = StyleTheme.Theme.loadTheme().fgcolor
        

        tipPercentile()
        calcTip()
        
    }
    
    
    @IBAction func appearResult(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            if self.billText.text!.isEmpty {
                self.resultView.alpha = 0
            }
            else {
                self.resultView.alpha = 1
            }
        })
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
        calcTip()
    }
}

