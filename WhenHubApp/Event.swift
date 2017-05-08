//
//  Event.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/6/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import Foundation

class Event {
    var id: String?
    var scheduleId: String?
    var name: String?
    var description: String?
    var order: Int?
    var image: String?
    var startDate: NSDate?
    var link: String?
    
    init(id: String?, scheduleId: String?, name: String?, description: String?, order: Int?, image: String?, startDate: NSDate?, link: String?) {
        self.id = id
        self.scheduleId = scheduleId
        self.name = name
        self.description = description
        self.order = order
        self.image = image
        self.startDate = startDate
        self.link = link
    }
}
