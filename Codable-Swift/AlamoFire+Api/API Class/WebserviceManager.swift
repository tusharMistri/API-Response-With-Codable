//
//  WebserviceManager.swift
//  AlamoFire+Api
//
//  Created by Tushar on 20/09/19.
//  Copyright © 2019 tushar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebserviceManager: NSObject {
    
    static let serviceManager = WebserviceManager()
    
    func apiResponse<T:Decodable>(method:HTTPMethod, param:[String:AnyObject]? = nil, api: APIName, completionHandler : @escaping (Bool, T?) -> Void){
        
        Alamofire.request(api.value(), method: method, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.value != nil{
                do{
                    let decodeEnum = try JSONDecoder().decode(T.self, from: response.data!)
                    completionHandler(true,decodeEnum)
                }catch{
                    completionHandler(false,nil)
                }
            }
        }
    }
    
}

extension WebserviceManager
{
    enum APIName {
        case getUserDetails
        case getUserPages
        
        func value() -> String {
            
            switch self {
            case .getUserDetails:
                return "https://jsonplaceholder.typicode.com/users"
            case .getUserPages:
                return "https://reqres.in/api/users?page=2"
            }
        }
    }
}
