//
//  MySchedulesViewController.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/5/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit

class MySchedulesViewController: UITableViewController, WhenHubAPIDelegate, ScheduleCellDelegate {
    var schedules: NSArray = []
    var customCell: ScheduleCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Schedules"
        let whenHubAPI = WhenHubAPI()
        whenHubAPI.delegate = self
        whenHubAPI.mySchedules()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 30
    }
    
    func onSuccess(data: NSArray?) {
        schedules = data!
        self.tableView.reloadData()
    }
    
    func onError(message: String) {
    }
    
    func onEvents(data: NSArray?) {
        let myEventsVC = self.storyboard?.instantiateViewController(withIdentifier: "MyEventsViewController") as! MyEventsViewController
        myEventsVC.events = data!.sorted(by: { ($0 as! Event).startDate!.compare(($1 as! Event).startDate! as Date) == .orderedDescending }) as NSArray
        self.navigationController?.pushViewController(myEventsVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        let schedule = schedules[indexPath.row] as! Schedule
        cell.delegate = self
        cell.render(schedule: schedule)

        return cell
    }
}
