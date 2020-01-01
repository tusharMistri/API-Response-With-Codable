//
//  ViewController.swift
//  AlamoFire+Api
//
//  Created by Tushar on 29/07/18.
//  Copyright © 2018 tushar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let BASEURL = "http://api.androidhive.info/contacts/"

class ViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet var viewAnimated: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.apiCallwithJsonSearialization()
        
        let dic1 = ["planet_position" : "Transiting Sun Opposition Natal Jupiter", "date":"8-7-2019"]
        let dic2 = ["planet_position" : "Transiting Moon Opposition Natal Mercury", "date":"8-7-2019"]
        let dic3 = ["planet_position" : "Transiting Venus Square Natal Mercury", "date":"11-7-2019"]
        let dic4 = ["planet_position" : "Transiting Mars Opposition Natal Uranus", "date":"8-7-2019"]
        let dic5 = ["planet_position" : "Transiting Venus Square Natal Sun", "date":"10-7-2019"]
        
        let aryDic = [dic1,dic2,dic3,dic4,dic5]
        let final = ["life_forecast":aryDic]
        
        print(final)
        
        var convertedArray: [Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD-MM-yyyy"
        
        for dic in aryDic {
            let date = dateFormatter.date(from: dic["date"]!)
            if let date = date {
                convertedArray.append(date)
            }
        }
        
        let ready = convertedArray.sorted(by: { $0.compare($1) == .orderedAscending })
        print(ready)
        
    }

    
    func apiCallwithJsonSearialization()
    {
        // prepare json data
        let json: [String: Any] = ["name": "abc@fife","salary":"pistol","age":"12"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/create")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }
    
    
    
    @IBAction func buttonClick(_ sender: UIButton)
    {
        if timer.isValid
        {
            viewAnimated.isHidden = true
            timer.invalidate()
        }
        else{
            viewAnimated.isHidden = false
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (status) in
                self.viewAnimation()
            }
        }
    }
    
    func viewAnimation()
    {
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.viewAnimated.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }) { (status) in
            UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.viewAnimated.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    func CallAPI()
    {
        
        Alamofire.request(BASEURL).responseJSON { (response) in
            if response.result.value != nil{
                
                let jsonData = JSON(response.result.value!)
                print("jsonData :\(jsonData)")
            }
        }
    }
    
    func APICALLPOST()
    {
        let json: [String: AnyObject] = ["name": "abc@fife" as AnyObject,"salary":"pistol" as AnyObject,"age":"12" as AnyObject]
        Alamofire.request("http://dummy.restapiexample.com/api/v1/create", method: .post, parameters: json,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
