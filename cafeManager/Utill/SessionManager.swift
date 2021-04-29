//
//  SessionManager.swift
//  NIBMCafe
//
//  Created by Admin on 2021-04-12.
//

import Foundation

class SessionManager{
    
    func getLogingStates() -> Bool{
       return UserDefaults.standard.bool(forKey: "USER_LOGGED")
       
        
    }
    
    func clearUserLoging(){
        UserDefaults.standard.setValue(false, forKey: "USER_LOGGED")
    }
    
    func saveUserLoging(user:User){
        UserDefaults.standard.setValue(true, forKey: "LOGGED_IN")
        UserDefaults.standard.setValue(user.userName ,forKey: "USER_NAME")
        UserDefaults.standard.setValue(user.userEmail ,forKey: "USER_Email")
        UserDefaults.standard.setValue(user.userPhone ,forKey: "USER_PHONE")
        
    }
    
    func getUserData() -> User {
      let user = User(
                      userName:UserDefaults.standard.string(forKey: "USER_NAME") ?? "",
                      userEmail: UserDefaults.standard.string(forKey: "USER_Email") ?? "",
                      userPassword: "",
                      userPhone: UserDefaults.standard.string(forKey: "USER_PHONE") ?? "")
        return user
    }
    
}
