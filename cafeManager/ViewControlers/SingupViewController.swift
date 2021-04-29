//
//  SingupViewController.swift
//  NIBMCafe
//
//  Created by Admin on 2021-04-11.
//

import UIKit
import Firebase
import Loaf

class SingupViewController: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphoneNumber: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
    }
    
    @IBAction func onRegisterbtn(_ sender: Any) {
        if !InputValidator.isValidName(name: txtname.text ?? ""){
            Loaf("invalied name", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidEmail(email: txtemail.text ?? ""){
            Loaf("invalied email Address ", state: .error, sender: self).show()
            return
        }
        if !InputValidator.isValidMobileNo(txtphoneNumber.text ?? ""){
            Loaf("invalied phone number ", state: .error, sender: self).show()
            return

        }
        if !InputValidator.isValidPassword( pass:txtpassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("invalied password", state: .error, sender: self).show()
            return
        }
        
        
        let user = User(userName: txtname.text ?? "", userEmail: txtemail.text ?? "", userPassword: txtpassword.text ?? "", userPhone:txtphoneNumber.text ?? "")
        
        registerUser(user: user)
        
    }
    
    @IBAction func onLoginbtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser (user: User) {
        Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword) { authResult, error in
            if let err  = error {
                print(err.localizedDescription)
                Loaf ("User Sign Up Failed", state: .error, sender: self).show()
                 return
            }
            self.saveUserData(user: user)
            
            
        }
        
    }
    
    
    func saveUserData(user: User){
        
        let userData = [
            "UserName" : user.userName,
            "UserEmail" : user.userEmail,
            "Userphone" : user.userPhone,
            "Userpassword" : user.userPassword
        ]
       
        
        
        self.ref.child("users").child(user.userEmail.replacingOccurrences(of: "@", with: "_")
                                        .replacingOccurrences(of: ".", with: "_")).setValue(userData){
            
            (error, ref) in
            
            if let err  = error {
                print(err.localizedDescription)
                Loaf ("User data not Saved on database", state: .error, sender: self).show()
                 return
                
            }
            
            Loaf ("User data Saved on database", state: .success, sender: self).show(){
                                                
                    type in
                    self.dismiss(animated: true, completion: nil)
            }
                                            
        }
        
    }
    
    
    
    
   /* func validateInput()-> Bool{
        guard let name = txtname.text else {
            print("name is null")
            return false
        }
        
        guard let email = txtemail.text else {
            print("email is null")
            return false
        }
        
        guard let phoneNumber = txtphoneNumber.text else {
            print("phone is null")
            return false
        }
        
        guard let password = txtpassword.text else {
            print("name is null")
            return false
        }
        
        if name.count < 5{
            print("Enter a valied Name")
            return false
        }
        
        if email.count < 5{
            print("Enter a valied email")
            return false
        }
        
        if phoneNumber.count < 10{
            print("Enter a valied phoneNumber")
            return false
        }
        
        if password.count < 5{
            print("Enter a valied Name")
            return false
        }
        
        return true
        
    }*/
    
    
   
}


