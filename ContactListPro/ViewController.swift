//
//  ViewController.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 17/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactListTableView: UITableView!
    var c = 1
    struct ContactList{
        let name: String
        let imageName: String

    }
    var data: [ContactList] = [
        ContactList(name: "Nasif Chowdhury", imageName: "na1"),
        ContactList(name: "Fahim Tridip", imageName: "na2"),
        ContactList(name: "Nasif", imageName: "e3"),
        ContactList(name: "Nasif Chowdhury", imageName: "e2"),
        ContactList(name: "Fahim Tridip", imageName: "na1"),
        ContactList(name: "Chowdhury", imageName: "na2"),
        ContactList(name: "Nasif", imageName: "e3"),
        ContactList(name: "Fahim Tridip", imageName: "na2"),
        ContactList(name: "Nasif Nasif", imageName: "na1"),
        ContactList(name: "Cxfxxx", imageName: "na2"),
        ContactList(name: "Fahim Tridip", imageName: "na1"),
        ContactList(name: "Cgvbsss", imageName: "na2"),
        ContactList(name: "Nasif", imageName: "na1"),
        ContactList(name: "Chddeed", imageName: "na2"),
        ContactList(name: "Nasif", imageName: "na1"),
        ContactList(name: "Chowdsd", imageName: "na2"),
        ContactList(name: "Abid", imageName: "na2"),
        ContactList(name: "Axxx", imageName: "na2"),
        ContactList(name: "zabb", imageName: "na1"),
        ContactList(name: "dad", imageName: "na2"),
        ContactList(name: "jihan", imageName: "na2"),
        ContactList(name: "Mother", imageName: "na2"),
        ContactList(name: "Xcs", imageName: "na2"),
        ContactList(name: "kk", imageName: "na2"),
        
    ]
   
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contact"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.placeholder = "Search"
        setupNavigationBar()

      //  navigationItem.searchController = searchBar
        
        contactListTableView.dataSource = self
        contactListTableView.delegate = self
        
       // let grouping = ["A", "B", "C"]
//        let groups = Dictionary(grouping: names) { (name) -> Character in
//                    return name.first!
//        }
//        print("THIS is printng ")
//        print(groups)
//        let sectionIndexes = groups.keys.sorted()
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
        sections = Dictionary(grouping: data) { (name) -> Character in

                   return name.name.first!

                   }
        
        .map { (key: Character, value: [ContactList]) -> (letter: Character, names:[ ViewController.ContactList]) in

                       (letter: key, names: value)

                   }

                   .sorted { (left, right) -> Bool in

                       left.letter < right.letter

                   }

               print(sections)

               print("total sections \(sections.count)")

               print(sections[0].data.count)

               print(sections[0].data[0])
        
       
        let cnt = sections.count
//        for i in 0...cnt-1 {
//            sectionNames.append(String(sections[i].letter))
//        }
        
        
       
       
        
        
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
            cell.label.text = name
            //inroder to show the image first i have to make a image outlet
          //  cell.iconImageView.image = UIImage(named: sections[indexPath.section].data[indexPath.row].imageName)
        }
        else{
            cell.label.text = ("\(filteredObjects[indexPath.row].name)")
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
        if isFilteringContact{
            let label = UILabel()
            label.text = "Searching results"
            label.backgroundColor = UIColor.gray
            return label
        }
        else{
            let label = UILabel()
            label.text = "\(sections[section].letter)"
            label.backgroundColor = UIColor.gray
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
            for i in 0...cnt-1 {
                sectionNames.append(String(sections[i].letter))
            }
            return sectionNames
        }
       

    }
        
    func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        print("select index is= \(index)")
        return index

    }
    //this is delegator work
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // using did select we can cotrol the montion of every row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
          print("index")
        }
       // print(data[indexPath.row])
        print("Index value \(indexPath.row)") // it returns the index value
    }


}

// MARK: - UISearchResult Updating and UISearchControllerDelegate  Extension
  extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text)
        let searchString = searchController.searchBar.text!
          if searchString.isEmpty {
              filteredObjects.removeAll()
          } else {
            filteredObjects = data.filter{ $0.name.range(of: searchString, options: .caseInsensitive) != nil }
          }
//        else {
//         filteredObjects = sections.filter{ $0secctions.data.name.range(of: searchString, options: .caseInsensitive) != nil }
//       }
  
        
        print(filteredObjects.count)
        if filteredObjects.count != 0 {
            self.isFilteringContact = true
        }
        else {
            self.isFilteringContact = false
        }
        
     
      contactListTableView.reloadData()
    
    }
 }
