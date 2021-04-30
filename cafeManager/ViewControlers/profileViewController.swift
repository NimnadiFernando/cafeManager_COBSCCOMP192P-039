//
//  profileViewController.swift
//  NIBMCafe
//
//  Created by Admin on 2021-04-28.
//

import UIKit

class profileViewController: UIViewController {
    let sessinMGR = SessionManager()

    @IBOutlet weak var txtusename: UILabel!
    
    @IBOutlet weak var txtPhone: UILabel!
    
    @IBOutlet weak var txtUserEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = sessinMGR.getUserData()
        txtusename.text = user.userName
        txtUserEmail.text = user.userEmail
        txtPhone.text = user.userPhone
    }
    

    

   
}
