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
        Alamofire.request("https://api.whenhub.com/api/users/me/schedules?filter[include]=media", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if ((response.error) == nil && response.response!.statusCode >= 200 && response.response!.statusCode < 300) {
                let schedules = response.result.value as! NSArray
                let data: NSMutableArray = []
                var media: NSArray?
                var icon: String?
                for schedule in schedules as! [NSDictionary] {
                    media = schedule.value(forKey: "media") as? NSArray
                    for md in media as! [NSDictionary] {
                        if (md.value(forKey: "type") as! String == "image") {
                            icon = md.value(forKey: "url") as? String
                        }
                    }
                    data.add(Schedule(id: schedule.value(forKey: "id") as? String,
                                      name: schedule.value(forKey: "name") as? String,
                                      description: schedule.value(forKey: "description") as? String,
                                      icon: icon))
                }
                self.delegate?.onSuccess(data: data)
            } else {
                self.delegate?.onError(message: "Sorry! It wasn't possible to fetch the user data.")
            }
        }
    }
    
    func myEvents(scheduleId: String) {
        let url: String = "https://api.whenhub.com/api/schedules/" + scheduleId + "?filter%5Binclude%5D%5Bevents%5D=media&filter%5Binclude%5D=media"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if ((response.error) == nil && response.response!.statusCode >= 200 && response.response!.statusCode < 300) {
                let data: NSMutableArray = []
                let json = response.result.value as! NSDictionary
                let events = json.value(forKey: "events") as! NSArray
                var id: String?
                var name: String?
                var description: String?
                var order: Int?
                var media: NSArray?
                var image: String?
                var startDate: NSDictionary?
                var link: NSDictionary?
                
                for event in events as! [NSDictionary] {
                    id = event.value(forKey: "id") as? String
                    name = event.value(forKey: "name") as? String
                    description = event.value(forKey: "description") as? String
                    order = event.value(forKey: "order") as? Int
                    media = event.value(forKey: "media") as? NSArray
                    startDate = event.value(forKey: "when") as? NSDictionary
                    link = event.value(forKey: "primaryAction") as? NSDictionary
                    
                    for md in media as! [NSDictionary] {
                        if (md.value(forKey: "type") as! String == "image") {
                            image = md.value(forKey: "url") as? String
                        }
                    }
                    
                    data.add(Event(id: id,
                                   scheduleId: scheduleId,
                                   name: name,
                                   description: description,
                                   order: order,
                                   image: image,
                                   startDate: startDate?.value(forKey: "startDate") as? String,
                                   link: link?.value(forKey: "url") as? String))
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
