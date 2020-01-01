//
//  RegisterViewController.swift
//  AlamoFire+Api
//
//  Created by Tushar on 12/08/18.
//  Copyright © 2018 tushar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var response : UserDetails? = nil
    @IBOutlet var txtContact: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonRegister(_ sender: UIButton)
    {
        let dic = NSMutableDictionary()
        dic.setValue(txtName.text!, forKey: Register_Name)
        dic.setValue(txtEmail.text!, forKey: Register_Email)
        dic.setValue(txtContact.text!, forKey: Register_Contact)
        dic.setValue(txtPassword.text!, forKey: Register_Password)
        
        self.validateRegisteration(_data: dic) { (status, error, response) in
            if status == false
            {
                APPDELEGATE.alert(message: error!)
            }
            else{
                print(response ?? "")
                let array = response?.data!
                let fiterData = array?.sorted(by: { (item1, item2) -> Bool in
                    return item1.firstName!.compare(item2.firstName!) == ComparisonResult.orderedAscending
                })
                print(fiterData ?? "")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension RegisterViewController
{
    func validateRegisteration(_data:NSMutableDictionary, completionblock:@escaping (Bool?,String?, UserDetails?)-> Void)
    {
        if (_data.value(forKey: Register_Name) as! String) == ""
        {
            completionblock(false,Error_register_name,nil)
        }
        else if (_data.value(forKey: Register_Email) as! String) == ""
        {
            completionblock(false,Error_register_email,nil)
        }
        else if (_data.value(forKey: Register_Password) as! String) == ""
        {
            completionblock(false,Error_register_password,nil)
        }
        else if (_data.value(forKey: Register_Contact) as! String) == ""
        {
            completionblock(false,Error_register_contact,nil)
        }
        else{
            let model = RegisterModel()
            model.registerUser { (userData, status) in
                if status{
                    completionblock(status,"", userData)
                }else{
                    completionblock(status,"",nil)
                }
            }
        }
    }
}
