//
//  ViewController.swift
//  WhenHubApp
//
//  Created by Rodrigo Suhr on 4/30/17.
//  Copyright © 2017 Rodrigo Suhr. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, WhenHubAPIDelegate {
    @IBOutlet weak var svProfile: UIStackView!
    @IBOutlet weak var svLoading: UIStackView!
    @IBOutlet weak var lblLoadingMessage: UILabel!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var imgUserphoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let whenHubAPI = WhenHubAPI()
        whenHubAPI.delegate = self
        whenHubAPI.myInfo()
        svProfile.isHidden = true
    }
    
    @IBAction func onMySchedules(_ sender: UIButton) {
        let mySchedulesVC = self.storyboard?.instantiateViewController(withIdentifier: "MySchedulesViewController")
        self.navigationController?.pushViewController(mySchedulesVC!, animated: true)
    }
    
    func onSuccess(data: NSArray?) {
        svLoading.isHidden = true
        svProfile.isHidden = false
        lblWelcome.text = lblWelcome.text! + " " + WhenHubAPI.getUserName()! + "!"
        let url = NSURL(string: WhenHubAPI.getUserPhoto()!)!
        imgUserphoto.af_setImage(withURL: url as URL)
    }
    
    func onError(message: String) {
        aiLoading.isHidden = true
        lblLoadingMessage.text = message
    }
}
