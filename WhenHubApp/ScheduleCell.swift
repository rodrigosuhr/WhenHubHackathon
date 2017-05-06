//
//  ScheduleCell.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/5/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell, WhenHubAPIDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    var schedule: Schedule?
    
    func render(schedule: Schedule) {
        self.schedule = schedule
        lblTitle.text = schedule.name
    }

    @IBAction func onEvents(_ sender: Any) {
        let whenHubAPI = WhenHubAPI()
        whenHubAPI.delegate = self
        whenHubAPI.myEvents(scheduleId: schedule!.id!)
    }
    
    func onSuccess(data: NSArray?) {
        print(data)
    }
    
    func onError(message: String) {
        
    }
}
