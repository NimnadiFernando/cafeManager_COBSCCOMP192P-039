//
//  StoreRootViewController.swift
//  cafeManager
//
//  Created by Nimnadi Frnando on 2021-04-30.
//

import UIKit

class StoreRootViewControlleBakr: UIViewController {
    
    var tabBarContainer:UITabBarController?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabBarSegway"{
            self.tabBarContainer = segue.destination as?UITabBarController
        }
        
        self.tabBarContainer?.tabBar.isHidden = true
    }
    

    @IBAction func SegIndexChanged(_ sender: UISegmentedControl) {
        tabBarContainer?.selectedIndex = sender.selectedSegmentIndex
    }
    
}
