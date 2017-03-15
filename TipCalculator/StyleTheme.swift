//
//  StyleTheme.swift
//  TipCalculator
//
//  Created by Krishna Alex on 3/14/17.
//  Copyright © 2017 Krishna Alex. All rights reserved.
//

import UIKit

class StyleTheme: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    */
    struct Theme{
        static var bgcolor = UIColor(red: 0.18, green: 0.21, blue: 0.28, alpha: 1.0)
        static var fgcolor = UIColor(red: 0.24, green: 027, blue: 0.36, alpha: 1.0)
        
        static func themeDark(){
            bgcolor = UIColor(red: 0.18, green: 0.21, blue: 0.28, alpha: 1.0)
            fgcolor = UIColor(red: 0.24, green: 0.27, blue: 0.36, alpha: 1.0)
        }
        static func themeLight(){
            bgcolor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
            fgcolor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1.0)
            
            
        }
        
        static let availableThemes = ["Light", "Dark"]
        static func loadTheme() -> (bgcolor: UIColor, fgcolor: UIColor){
            let defaults = UserDefaults.standard
            if let themeName = defaults.string(forKey: "theme") {
                if themeName == "Light"
                {
                    themeLight()
                    
                }
                else{
                    defaults.set("Dark", forKey: "theme")
                    defaults.synchronize()
                    themeDark()
                }
                
            }
         return(bgcolor, fgcolor)
        }
    }

}
