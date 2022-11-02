//
//  SeocndViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 23/10/22.
//

import UIKit
protocol  DataPassSecondController {
    func dataPassingSecond(name: String, imageName: UIImage?, phoneNumber: String, indexPathSection: Int, indexPathRaw: Int, oldName: String, oldNumber: String, id: UUID)

}

class SeocndViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    
   var userName = ""
    var number = " "
    var indexPathSection = 0
    var indexPathRaw = 0
    var displayImage: UIImage?
    var oldName = " "
    var oldNumber = " "
    var contactid = UUID()
    
   var delegate2:DataPassSecondController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgUser.layer.cornerRadius = 20

        self.imgUser.clipsToBounds = true

        self.imgUser.layer.borderColor = UIColor.white.cgColor
        
        txtName.text = userName
        txtName.textAlignment = .center
        txtPhoneNumber.text = number
        txtPhoneNumber.textAlignment = .center
        imgUser.image = displayImage
        
    }
    
    @IBAction func btnUpdate(_ sender: Any){
        delegate2.dataPassingSecond(name: txtName.text!, imageName: imgUser.image, phoneNumber: txtPhoneNumber.text!, indexPathSection: indexPathSection, indexPathRaw: indexPathRaw, oldName: oldName, oldNumber: oldNumber, id: contactid)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func photUpdate(_ sender: Any){
        let vc = UIImagePickerController()
        print("this is pressed1")
        vc.sourceType = .photoLibrary
            print("this is pressed2")
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        print("this is pressed3")
    }


}
extension SeocndViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imgUser.image = image
            print("IN")
           
        }
       
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
