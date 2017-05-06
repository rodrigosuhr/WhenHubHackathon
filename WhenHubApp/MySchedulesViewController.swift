//
//  MySchedulesViewController.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/5/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit

class MySchedulesViewController: UITableViewController, WhenHubAPIDelegate {
    var schedules: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Schedules"
        let whenHubAPI = WhenHubAPI()
        whenHubAPI.delegate = self
        whenHubAPI.mySchedules()
    }
    
    func onSuccess(data: NSArray?) {
        schedules = data!
        self.tableView.reloadData()
    }
    
    func onError(message: String) {
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
        cell.render(schedule: schedule)

        return cell
    }
 
}
