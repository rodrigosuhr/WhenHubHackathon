//
//  EventCell.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 5/6/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class EventCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var imgMap: UIImageView!
    @IBOutlet var imgImage: UIImageView!
    @IBOutlet var lblStartDate: UILabel!
    @IBOutlet var lblDesc: UILabel!
    var event: Event?
    
    func render(event: Event) {
        self.event = event
        lblTitle.text = event.name
        imgImage.af_setImage(withURL: NSURL(string: event.image!)! as URL)
        // TODO: get the Event's location coordinates to use in this url
        let mapUrl: String = "https://maps.google.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&sensor=false"
        imgMap.af_setImage(withURL: NSURL(string: mapUrl)! as URL)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        lblStartDate.text = "Starts in " + dateFormatter.string(from: event.startDate! as Date)
        lblDesc.text = event.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    @IBAction func onActionLink(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: event!.link!)! as URL, options: [String: Any](), completionHandler: nil)
    }
}
