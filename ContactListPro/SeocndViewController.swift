//
//  SeocndViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit
protocol  DataPassSecondController {
    func dataPassingSecond(name: String, imageName: String, phoneNumber: String, indexPathSection: Int, indexPathRaw: Int)

}

class SeocndViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    
   var userName = ""
    var img = " "
    var number = " "
    var indexPathSection = 0
    var indexPathRaw = 0
   var delegate2:DataPassSecondController!
    override func viewDidLoad() {
        super.viewDidLoad()
       txtName.text = userName
        txtName.textAlignment = .center
        imgUser.image = UIImage(named: img)
        txtPhoneNumber.text = number
        txtPhoneNumber.textAlignment = .center
        
        
    }
    
    @IBAction func btnUpdate(_ sender: Any){
        delegate2.dataPassingSecond(name: txtName.text!, imageName: img, phoneNumber: txtPhoneNumber.text!, indexPathSection: indexPathSection, indexPathRaw: indexPathRaw )
        self.navigationController?.popViewController(animated: true)
    }
    


}
