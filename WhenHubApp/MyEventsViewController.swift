//
//  MyEventsViewController.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/6/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit

class MyEventsViewController: UITableViewController {
    @IBOutlet weak var lblNoEvents: UILabel!
    var events: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Events"
        if (events.count > 0) {
            lblNoEvents.removeFromSuperview()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row] as! Event
        cell.render(event: event)
        
        return cell
    }
}
