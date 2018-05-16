//
//  PhoneContacts.swift
//  MicroMoney
//
//  Created by Coco Xtet Pai on 1/29/18.
//  Copyright © 2018 Coco Xtet Pai. All rights reserved.
//

import Foundation
import ContactsUI
import Contacts

enum ContactsFilter {
    case none
    case mail
    case message
}

typealias ContactLists = [[String: String]]

class PhoneContacts {
    
    class func getContacts(filter: ContactsFilter = .none) -> [CNContact] {
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
//            CNContactProperty(),
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
//            Debug.Log(message: "Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
//                Debug.Log(message: "Error fetching containers")
            }
        }
        return results
    }
}
