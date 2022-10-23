//
//  SeocndViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit

class SeocndViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    var userName = "This is name"
    var testName = "This is test name"

    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = userName

        // Do any additional setup after loading the view.
    }
    


}
