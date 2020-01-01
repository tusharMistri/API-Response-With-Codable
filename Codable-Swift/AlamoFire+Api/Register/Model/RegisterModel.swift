//
//  RegisterModel.swift
//  AlamoFire+Api
//
//  Created by Tushar on 12/08/18.
//  Copyright © 2018 tushar. All rights reserved.
//

import UIKit

//Key Param

let Register_Name = "Register_Name"
let Register_Email = "Register_Email"
let Register_Password = "Register_Password"
let Register_Contact = "Register_Contact"

//Validation Param

let Error_register_name = "Enter name"
let Error_register_email = "Enter email"
let Error_register_password = "Enter password"
let Error_register_contact = "Enter contact"

class RegisterModel: NSObject
{
    func registerUser(completionBlock:@escaping (UserDetails?,Bool) -> Void) {
        
        WebserviceManager.serviceManager.apiResponse(method: .get, api: .getUserPages) { (isSuccess:Bool, objResponse:UserDetails?) in
            completionBlock(objResponse,isSuccess)
        }
        
    }
}







