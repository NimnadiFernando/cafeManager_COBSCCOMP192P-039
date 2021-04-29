//
//  EntityModle.swift
//  NIBMCafe
//
//  Created by Admin on 2021-04-11.
//

import Foundation

struct User {
    var userName:String
    var userEmail:String
    var userPassword:String
    var userPhone:String
}

struct FoodItem {
    var _id:String
    var foodName:String
    var foodDiscription:String
    var foodPrice:Double
    var discount:Int
    var image: String
    var category : String
    
}
struct Order {
    var orderID: String = ""
    var orderStatus : String = ""
    var ordertotal : Double = 0
}
