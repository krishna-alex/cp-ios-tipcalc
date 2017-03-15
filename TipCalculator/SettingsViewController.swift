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
    @IBOutlet weak var themeControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    @IBOutlet var settingsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.backgroundColor = StyleTheme.Theme.loadTheme().bgcolor
        
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
        if let currentTheme = defaults.string(forKey: "theme")
        {
            if currentTheme == "Light" {
                self.themeControl.selectedSegmentIndex = 0
            }
            else {
            
                self.themeControl.selectedSegmentIndex = 1
            }
        }
        else {
        
            self.themeControl.selectedSegmentIndex = 1
        }
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func setDefaultTip(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let selectedTipValue = tipPercentages[defaltTipControl.selectedSegmentIndex]
        defaults.set(selectedTipValue, forKey: "defaultTip")
        defaults.synchronize()
        
    }
    
    @IBAction func setTheme(_ sender: Any) {
        let themes = StyleTheme.Theme.availableThemes
        let selectedTheme = themes[themeControl.selectedSegmentIndex]
        defaults.set(selectedTheme, forKey: "theme")
        defaults.synchronize()
        settingsView.backgroundColor = StyleTheme.Theme.loadTheme().bgcolor
        print(selectedTheme)
    }
    

}
