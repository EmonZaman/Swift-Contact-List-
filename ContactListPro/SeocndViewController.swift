//
//  SeocndViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit
protocol  DataPassSecondController {
    func dataPassingSecond(name: String, imageName: UIImage?, phoneNumber: String, indexPathSection: Int, indexPathRaw: Int, oldName: String, oldNumber: String)

}

class SeocndViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    
   var userName = ""
    var number = " "
    var indexPathSection = 0
    var indexPathRaw = 0
    var displayImage = UIImage()
    var oldName = " "
    var oldNumber = " "
    
   var delegate2:DataPassSecondController!
    override func viewDidLoad() {
        super.viewDidLoad()
       txtName.text = userName
        txtName.textAlignment = .center
        txtPhoneNumber.text = number
        txtPhoneNumber.textAlignment = .center
        imgUser.image = displayImage
        
    }
    
    @IBAction func btnUpdate(_ sender: Any){
        delegate2.dataPassingSecond(name: txtName.text!, imageName: imgUser.image, phoneNumber: txtPhoneNumber.text!, indexPathSection: indexPathSection, indexPathRaw: indexPathRaw, oldName: oldName, oldNumber: oldNumber )
        self.navigationController?.popViewController(animated: true)
    }
    


}
