//
//  ContactAddViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit

protocol  DataPass {
    func dataPassing(name: String, imageName: String )
    
}

class ContactAddViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    
    var delegate:DataPass!



    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.placeholder = "Add Contact"
        

    }
    @IBAction func btnAddContact(_ sender: Any){
//        if let vc = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController{
//
//            vc.data.append(ViewController.ContactList(name: "AAAAA", imageName: "ns1"))
//           // vc.userName = sections[indexPath.section].data[indexPath.row].name
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        self.dismiss(animated: true, completion: nil)
        delegate.dataPassing(name: txtField.text!, imageName: "na1")
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    


}
