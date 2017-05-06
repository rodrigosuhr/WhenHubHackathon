//
//  Schedule.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/5/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import Foundation

class Schedule {
    var id: String?
    var name: String?
    var description: String?
    var icon: String?
    
    init(id: String?, name: String?, description: String?, icon: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
    }
}
