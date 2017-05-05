//
//  WhenHubAPI.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 4/30/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import Foundation
import Alamofire

protocol WhenHubAPIDelegate: class {
    func onSuccess(data: NSArray?)
    func onError(message: String)
}

class WhenHubAPI {
    weak var delegate:WhenHubAPIDelegate?
    var headers: [String:String]
    
    init() {
        headers = ["Authorization": WhenHubAPIConstants.ACCESS_TOKEN]
    }
    
    func myInfo() {
        Alamofire.request("https://api.whenhub.com/api/users/me", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if ((response.error) == nil && response.response!.statusCode >= 200 && response.response!.statusCode < 300) {
                let json = response.result.value as! NSDictionary
                let name = json.value(forKey: "name") as! NSDictionary
                self.storeUserData(username: name.value(forKey: "givenName") as! String, user_photo: json.value(forKey: "photo") as! String)
                self.delegate?.onSuccess(data: nil)
            } else {
                self.delegate?.onError(message: "Sorry! It wasn't possible to fetch the user data.")
            }
        }
    }
    
    func mySchedules() {
        Alamofire.request("https://api.whenhub.com/api/users/me/schedules", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if ((response.error) == nil && response.response!.statusCode >= 200 && response.response!.statusCode < 300) {
                let schedules = response.result.value as! NSArray
                let data: NSMutableArray = []
                for schedule in schedules as! [NSDictionary] {
                    data.add(Schedule(name: schedule.value(forKey: "name") as? String,
                                      description: schedule.value(forKey: "description") as? String,
                                      icon: schedule.value(forKey: "icon") as? String))
                }
                self.delegate?.onSuccess(data: data)
            } else {
                self.delegate?.onError(message: "Sorry! It wasn't possible to fetch the user data.")
            }
        }
    }
    
    private func storeUserData(username: String, user_photo: String) {
        UserDefaults.standard.set(username, forKey: "WhenHubAPI_Username")
        UserDefaults.standard.set(user_photo, forKey: "WhenHubAPI_UserPhoto")
    }
    
    class func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "WhenHubAPI_Username")
    }
    
    class func getUserPhoto() -> String? {
        return UserDefaults.standard.string(forKey: "WhenHubAPI_UserPhoto")
    }
}
