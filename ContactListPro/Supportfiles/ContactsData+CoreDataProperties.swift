//
//  ContactsData+CoreDataProperties.swift
//  ContactListPro
//
//  Created by Twinbit Limited on 1/11/22.
//
//

import Foundation
import CoreData


extension ContactsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactsData> {
        return NSFetchRequest<ContactsData>(entityName: "ContactsData")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var profilePic: String?
    @NSManaged public var id: UUID?

}

extension ContactsData : Identifiable {

}
