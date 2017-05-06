//
//  EventCell.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/6/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    var event: Event?
    
    func render(event: Event) {
        self.event = event
        lblTitle.text = event.name
    }
}
