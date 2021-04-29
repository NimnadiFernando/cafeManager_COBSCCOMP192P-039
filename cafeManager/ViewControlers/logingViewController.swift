//
//  logingViewController.swift
//  NIBMCafe
//
//  Created by Admin on 2021-04-11.
//

import UIKit
import Firebase
import FirebaseDatabase
import Loaf

class logingViewController: UIViewController {
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        

        
    }
    
   
    @IBAction func onLogingBtn(_ sender: UIButton) {
        
        if !InputValidator.isValidEmail(email: txtemail.text ?? ""){
            Loaf("invalied email Address ", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidPassword( pass:txtpassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("invalied password", state: .error, sender: self).show()
            return
        }
        
        authenticateUser(email: txtemail.text!, password: txtpassword.text!)
        
       
        
    }
    
   /* func validateInput() -> Bool{
        
        guard let email = txtemail.text else {
            print("Email is null")
            return false
        }
        
        guard let password = txtpassword.text else {
            print("password is null")
            return false
        }
        
        if email.count < 5 {
            print("enter a valid Email")
            return false
        }
        if password.count < 5 {
            print("enter a valid email")
            return false
        }
        
        return true
    }*/
    
    func authenticateUser(email:String,password:String){
        
        Auth.auth().signIn(withEmail: email, password: password){
            authResult, error in
            
            if let error = error{
                print(error.localizedDescription)
                Loaf("user sinup faild ", state: .error, sender: self).show()
                return
            }
            if let email = authResult?.user.email {
                self.getUserData(email: email)
                }
            else{
                Loaf ("User email not found", state: .error, sender: self).show()
                return
                
            }
         
      
        
        }
        
    }
  
    func getUserData (email :String){
        
        ref.child("users")
            .child(email
                    .replacingOccurrences(of: "@", with: "_")
                    .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
                                        (snapshot)  in
                        
                        if snapshot.hasChildren(){
                            if let data = snapshot.value {
                                if let userData = data as? [String : String] {
                                   
                                    let user = User(
                                        userName: userData ["UserName"]!,
                                        userEmail: userData ["UserEmail"]!,
                                        userPassword:userData ["Userpassword"]!,
                                        userPhone: userData ["Userphone"]!)
                                    
                                    let sessionMGR = SessionManager()
                                    sessionMGR.saveUserLoging(user:user)
                                    self.performSegue(withIdentifier: "SingInToHome", sender: nil)
                                }
                                
                            }
                            
                            
                            
                        } else{
                            
                            Loaf ("User not found", state: .error, sender: self).show()
                            
                        }
                    })
                                        
    }

}
