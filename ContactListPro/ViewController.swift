//
//  ViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 17/10/22.
//

import UIKit
import Contacts
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataPass, DataPassSecondController {
    

    
    @IBOutlet weak var contactListTableView: UITableView!
    
    
    var c = 1
    struct ContactList{
        var name: String
        var thumbImage: UIImage?
        var phoneNumber: String
        var id: UUID?
        
    }
    var data =  [ContactList]()
    //
    //        ContactList(name: "Nasif Chowdhury", imageName: "na1"),
    //        ContactList(name: "Fahim Tridip", imageName: "na2"),
    //        ContactList(name: "Nasif", imagexdxdName: "e3"),
    //        ContactList(name: "Nasif Chowdhury", imageName: "e2"),
    //        ContactList(name: "Fahim Tridip", imageName: "na1"),
    //        ContactList(name: "Chowdhury", imageName: "na2"),
    //        ContactList(name: "Nasif", imageName: "e3"),
    //        ContactList(name: "Fahim Tridip", imageName: "na2"),
    //        ContactList(name: "Nasif Nasif", imageName: "na1"),
    //        ContactList(name: "Cxfxxx", imageName: "na2"),
    //        ContactList(name: "Fahim Tridip", imageName: "na1"),
    //        ContactList(name: "Cgvbsss", imageName: "na2"),
    //        ContactList(name: "Nasif", imageName: "na1"),
    //        ContactList(name: "Chddeed", imageName: "na2"),
    //        ContactList(name: "Nasif", imageName: "na1"),
    //        ContactList(name: "Chowdsd", imageName: "na2"),
    //        ContactList(name: "Abid", imageName: "na2"),
    //        ContactList(name: "Axxx", imageName: "na2"),
    //        ContactList(name: "zabb", imageName: "na1"),
    //        ContactList(name: "dad", imageName: "na2"),
    //        ContactList(name: "jihan", imageName: "na2"),
    //        ContactList(name: "Mother", imageName: "na2"),
    //        ContactList(name: "Xcs", imageName: "na2"),
    //        ContactList(name: "kk", imageName: "na2"),
    
    // ]
    
    
    var filteredObjects = [ContactList]()
    // var filteredObjects = [(letter: Character, data: [ContactList])]()
    
    let twoDimensonalArray = [
        ["name1", "name1", "name1"],
        ["name 2"],
        ["name3", "name3", "name3", "name3"]
        
    ]
    var names = ["bname1", "aname1", "cname1", "annna"]
    
    //  var sections = [(letter: Character, names: [String])]()
    var sections = [(letter: Character, data: [ContactList])]()
    var sectionNames: [String] = []
    var searchString = ""
    lazy var searchBar = UISearchBar(frame: .zero)
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    var isFilteringContact = false
    
    private func fetchContacts(){
        
        print("trying to fetching contacts")
        let store = CNContactStore()
        store.requestAccess(for: .contacts){ (granted, err) in
            if let err = err{
                print("failed to request access", err)
                return
            }
            if granted{
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
                
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do{
                    
                    try store.enumerateContacts(with: request, usingBlock: {
                        (contact, stopPonterIfYouWantToStopEnmurating) in
                        print(contact.givenName)
                        print(contact.familyName)
                        var image: UIImage?
                        if let data = contact.imageData {
                            image = UIImage(data: data)
                            print("IMGGGG  ", image?.size)
                        }
                        
                  
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")
                        //  ContactList.init(name: contact.familyName, imageName: contact.givenName)
                        let fullName = contact.givenName + " " + contact.familyName
                        
                       // let imgData = contact.imageData = UIImage()
                        print("IMMMmmmmmmmmmm")
                        let uuid = UUID().uuidString
                        print("UUIDDDDDDDDDDDDDDD")
                        print(uuid)
                        print("endddd")
//                        self.data.append(ContactList(name: fullName, //thumbImage: UIImage(named: "na1") ,
//                                                     thumbImage: image ?? UIImage(named: "na1") ,
//                                                     phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? ""))
                        print("Image Data")
                    
                        let contactInfo = ContactsData(context: PersistentStorage.shared.context)

                        contactInfo.name = fullName
                        contactInfo.mobile = contact.phoneNumbers.first?.value.stringValue ?? ""
                        contactInfo.id = UUID()
                        if image != nil{
                            contactInfo.profilePic = self.saveImageToDocumentDirectory(image: image, id: contactInfo.id)
                        }
                      
                        
                        PersistentStorage.shared.saveContext()
                        
                        
                    })
                    print("access granted")
                    
                }
                catch let err {
                    print("failed to enmurate contacts", err)
                    
                }
                
            }
            else{
                print("access denied")
            }
            
        }
        
        
        
    }
   private func DataConvert(){
    do {
        guard let result =   try PersistentStorage.shared.context.fetch(ContactsData.fetchRequest()) as? [ContactsData] else {return}
        print("fetching data")
        
        var image: UIImage?
        
       
        
        
        result.forEach { ContactsData in
            
            print("Contact Data data dara raaaaaaaaaaaa")
            if ContactsData.profilePic != nil {
                image = loadImageFromDocumentDirectory(nameOfImage: ContactsData.profilePic ?? " ")
                self.data.append(ContactList(name: ContactsData.name ?? "no name", thumbImage: image, phoneNumber: ContactsData.mobile ?? "00", id: ContactsData.id))
            }
            else{
                self.data.append(ContactList(name: ContactsData.name ?? "no name", thumbImage: UIImage(named: "e3"), phoneNumber: ContactsData.mobile ?? "00", id: ContactsData.id))
                
            }
          
//            if let img = ContactsData.profilePic {
//                image = UIImage(named: img)
//                print("IMGGGG  ", image?.size)
//            }
            
            
        }
        
        
        
      
    } catch let error {
        debugPrint(error)
    }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //  view.backgroundColor = .red
        navigationItem.title = "Contact"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.placeholder = "Search"
        setupNavigationBar()
        
        fetchContacts()
        DataConvert()
        
        //  navigationItem.searchController = searchBar
        
        contactListTableView.dataSource = self
        contactListTableView.delegate = self
        
        // let grouping = ["A", "B", "C"]
        //        let groups = Dictionary(grouping: names) { (name) -> Character in
        //                    return name.first!
        //        }
        //        print("THIS is printng ")
        //        let sectionIndexes = groups.keys.sorted()
        //        print(groups)
        //        print(sectionIndexes)
        //        print(groups[sectionIndexes[0]]!)
        
        // sorted a structure
        data = data.sorted(by: { lhs, rhs in
            
            return lhs.name < rhs.name
            
        })
        print(data)
        names.append("cname")
        //        sections = Dictionary(grouping: names) { (name) -> Character in
        //                return name.first!
        //            }
        //            .map { (key: Character, value: [String]) -> (letter: Character, names: [String]) in
        //                (letter: key, names: value)
        //            }
        //            .sorted { (left, right) -> Bool in
        //                left.letter < right.letter
        //            }
        //        sections = Dictionary(grouping: data) { (name) -> Character in
        //
        //                   return name.name.first!
        //
        //                   }
        //
        //        .map { (key: Character, value: [ContactList]) -> (letter: Character, names:[ ViewController.ContactList]) in
        //
        //                       (letter: key, names: value)
        //
        //                   }
        //
        //                   .sorted { (left, right) -> Bool in
        //
        //                       left.letter < right.letter
        //
        //                   }
        
        //   print(sections)
        self.relaod()
        
        print("total sections \(sections.count)")
        
        //   print(sections[0].data.count)
        
        //   print(sections[0].data[0])
        
        
        //              let cnt = sections.count
        //        for i in 0...cnt-1 {
        //            sectionNames.append(String(sections[i].letter))
        //        }
//        createcontact()
//        fetchContactCoreData()
    
    }
    
    //data documentary
    func saveImageToDocumentDirectory(image: UIImage?, id: UUID? ) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(id).jpeg"// name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image?.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileName
            } catch {
                print("error saving file:", error)
            }
        }
        return nil
    }
    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        print(paths.first)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "na1")!
    }

    //coreDataTesting
    func createcontact(){
            
        let contact = ContactsData(context: PersistentStorage.shared.context)
            
        contact.name = "Zaman11111122222222222222222222222222222222"
        contact.mobile = "011121"
        contact.id = UUID()
        PersistentStorage.shared.saveContext()
      
            
        }
        
    func fetchContactCoreData(){
    
            do {
                guard let result =   try PersistentStorage.shared.context.fetch(ContactsData.fetchRequest()) as? [ContactsData] else {return}
                print("fetching data")
                print(result.forEach({debugPrint($0.name)}))
                print(result.forEach({debugPrint($0.mobile)}))
                print("IDDD")
                print(result.forEach({debugPrint($0.id)}))
                
              
            } catch let error {
                debugPrint(error)
            }
    }

    func relaod(){
        sections = Dictionary(grouping: data) { (name) -> Character in
            
            return name.name.first!
            
        }
        
        .map { (key: Character, value: [ContactList]) -> (letter: Character, names:[ ViewController.ContactList]) in
            
            (letter: key, names: value)
            
        }
        
        .sorted { (left, right) -> Bool in
            
            left.letter < right.letter
            
        }
    }
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFilteringContact ? self.filteredObjects.count : self.sections[section].data.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let contact = data[indexPath.row]
        let cell = contactListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        //        cell.label.text = contact.name
        //
        //       // cell.label.text = names[indexPath.row]
        //        cell.iconImageView.image = UIImage(named: contact.imageName)
        //
        //        print("\(c)st time")
        //        c = c + 1
        //
        //        return cell
        
        //twodimesional arry
        if(isFilteringContact == false)
        {
            let name = sections[indexPath.section].data[indexPath.row].name
            let Imagename = sections[indexPath.section].data[indexPath.row].thumbImage
            cell.label.text = name
            cell.imgImage.image = Imagename
            //inroder to show the image first i have to make a image outlet
            //  cell.iconImageView.image = UIImage(named: sections[indexPath.section].data[indexPath.row].imageName)
        }
        else{
            cell.label.text = ("\(filteredObjects[indexPath.row].name)")
            cell.imgImage.image =  filteredObjects[indexPath.row].thumbImage
            
        }
        
        // cell.label.text = "\(name) in section \(indexPath.section) row \(indexPath.row) "
        
        //        if isFilteringContact {
        //            cell.label.text = "Name"
        //        }
        // contactListTableView.reloadData()
        
        // sorting
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.isFilteringContact ? 1 : self.sections.count
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFilteringContact && filteredObjects.count == 0 {
            let label = UILabel()
            label.text = "Sorry No User Found for this name"
            label.backgroundColor = UIColor.red
            return label
        }
        else if isFilteringContact{
            let label = UILabel()
            label.text = "Serch Results"
            label.backgroundColor = UIColor.gray
            return label
        }
        
        else{
            let label = UILabel()
            label.text = "\(sections[section].letter)"
            label.backgroundColor = UIColor.gray
            label.textColor = .white
            // label.font = .boldSystemFont(ofSize: 16)
            
            return label
        }
        
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        //sectionNames.removeAll()
        if isFilteringContact{
            sectionNames.removeAll()
            return sectionNames
            
        }
        else{
            let cnt = sections.count
            print("CNT VALUE IS \(cnt)")
            sectionNames.removeAll()
            if cnt > 0{
                for i in 0...cnt-1 {
                    sectionNames.append(String(sections[i].letter))
                }
            }
            
            return sectionNames
        }
    }
    
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        print("Selected SECTION is = \(index)")
        return index
        
    }
    //this is delegator work
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // using did select we can cotrol the montion of every row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        print("Index value \(indexPath.row)") // it returns the index value
        print(sections[indexPath.section].data[indexPath.row].name)
        if let vc = storyboard?.instantiateViewController(identifier: "SeocndViewController") as? SeocndViewController{
            vc.delegate2 = self
            
            vc.indexPathSection = indexPath.section
            vc.indexPathRaw = indexPath.row
            
            
            vc.contactid = sections[indexPath.section].data[indexPath.row].id!
            
        
            vc.userName = sections[indexPath.section].data[indexPath.row].name
            vc.oldName = sections[indexPath.section].data[indexPath.row].name
            vc.oldNumber = sections[indexPath.section].data[indexPath.row].phoneNumber
            //vc.imgUser.image = UIImage(named: sections[indexPath.section].data[indexPath.row].imageName )
            var image = sections[indexPath.section].data[indexPath.row].thumbImage
            print( sections[indexPath.section].data[indexPath.row].thumbImage)
            vc.displayImage = image
            vc.number = sections[indexPath.section].data[indexPath.row].phoneNumber
           // vc.delegate = self
//            sections[indexPath.section].data[indexPath.row].name = vc.userName
//            sections[indexPath.section].data[indexPath.row].phoneNumber = vc.number
//            sections[indexPath.section].data[indexPath.row].imageName = vc.img
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func btnContactAdd(_ sender: UIBarButtonItem) {
        //        let controller = storyboard?.instantiateViewController(identifier: "ContactAddViewController") as! ContactAddViewController
        if let vc = storyboard?.instantiateViewController(identifier: "ContactAddViewController") as? ContactAddViewController{
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            
            // vc.userName = sections[indexPath.section].data[indexPath.row].name
            // self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    func dataPassing(name: String, imageName: UIImage?, number: String) {
        let contactInfo = ContactsData(context: PersistentStorage.shared.context)
        let uuid = UUID().uuidString
        contactInfo.name = name
        contactInfo.mobile = number ?? ""
        contactInfo.id = UUID()
        if imageName != nil{
            contactInfo.profilePic = self.saveImageToDocumentDirectory(image: imageName, id: contactInfo.id)
        }
        
        PersistentStorage.shared.saveContext()
//        self.data.append(ContactList(name: name ?? "no name", thumbImage: imageName, number: number ?? "00"))
        print("Back \(name)")
        self.data.append(ContactList(name: name, thumbImage: imageName, phoneNumber: number, id: contactInfo.id))
        print(data)
        self.relaod()
        
        contactListTableView.reloadData()
    }
    func dataPassingSecond(name: String, imageName: UIImage?, phoneNumber: String, indexPathSection: Int, indexPathRaw: Int, oldName: String, oldNumber: String, id: UUID) {
        
        for index in 0..<data.count{
            if data[index].name == oldName && data[index].phoneNumber == oldNumber{
                self.data[index].name = name
                self.data[index].phoneNumber = phoneNumber
                self.data[index].thumbImage = imageName
                break
            }
        }
        print("IDDD")
        print(id)
        let contact = getContactForUpdateAndDelete(byIdentifier: id)
        contact?.name = name
        contact?.mobile = phoneNumber
        
        contact?.profilePic = self.saveImageToDocumentDirectory(image: imageName, id: contact?.id)
        
        
        
        
        PersistentStorage.shared
                    .saveContext()
        
        
        print("OLD NAME")
        print(oldName)
        
        print("here it comes")
        print(name)
        print(indexPathRaw)
        self.relaod()
        contactListTableView.reloadData()
        
        
    }
    func getContactForUpdateAndDelete(byIdentifier id: UUID) -> ContactsData? {
        
        let fetchRequest = NSFetchRequest<ContactsData>(entityName: "ContactsData")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else {return nil}
            
            return result
            
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    
        
    }
   
    
    
}

// MARK: - UISearchResult Updating and UISearchControllerDelegate  Extension
extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text)
        searchString = searchController.searchBar.text!
        print("Search sring count value \(searchString.count)")
        if searchString.isEmpty {
            filteredObjects.removeAll()
        } else {
            filteredObjects = data.filter{ $0.name.range(of: searchString, options: .caseInsensitive) != nil }
        }
        //        else {
        //         filteredObjects = sections.filter{ $0secctions.data.name.range(of: searchString, options: .caseInsensitive) != nil }
        //       }
        
        
        print(filteredObjects.count)
        if filteredObjects.count == 0 && searchString.count != 0 {
            self.isFilteringContact = true
        }
        else if filteredObjects.count != 0 {
            self.isFilteringContact = true
        }
        else {
            self.isFilteringContact = false
        }
        contactListTableView.reloadData()
        
    }
}
