//
//  ScheduleCell.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/5/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ScheduleCellDelegate: class {
    func onEvents(data: NSArray?)
}

class ScheduleCell: UITableViewCell, WhenHubAPIDelegate {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    weak var delegate:ScheduleCellDelegate?
    var schedule: Schedule?
    
    func render(schedule: Schedule) {
        self.schedule = schedule
        lblName.text = schedule.name
        lblDescription.text = schedule.description
        let url = NSURL(string: schedule.icon!)! as URL
        imgIcon.af_setImage(withURL: url)
    }

    @IBAction func onEvents(_ sender: Any) {
        let whenHubAPI = WhenHubAPI()
        whenHubAPI.delegate = self
        whenHubAPI.myEvents(scheduleId: schedule!.id!)
    }
    
    func onSuccess(data: NSArray?) {
        delegate?.onEvents(data: data)
    }
    
    func onError(message: String) {
    }
}
