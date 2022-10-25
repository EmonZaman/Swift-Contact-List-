//
//  ContactAddViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit

protocol  DataPass {
    func dataPassing(name: String, imageName: UIImage?, number: String )
    
}

class ContactAddViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var imgUpload: UIImageView!
    
    var delegate:DataPass!



    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.placeholder = "Contact Name"
        txtNumber.placeholder = "Contact Number"
        

    }
    @IBAction func btnAddContact(_ sender: Any){
//        if let vc = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController{
//
//            vc.data.append(ViewController.ContactList(name: "AAAAA", imageName: "ns1"))
//           // vc.userName = sections[indexPath.section].data[indexPath.row].name
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        self.dismiss(animated: true, completion: nil)
        delegate.dataPassing(name: txtField.text!, imageName: imgUpload.image, number: txtNumber.text!)
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func pickPhoto(_ sender: Any){
        let vc = UIImagePickerController()
        print("this is pressed1")
        vc.sourceType = .photoLibrary
            print("this is pressed2")
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("this is pressed3")
        
    }
    
    @IBAction func btnCancle(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    


}

extension ContactAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imgUpload.image = image
            print("IN")
           
        }
       
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
