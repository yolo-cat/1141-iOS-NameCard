//
//  Contact.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import Foundation

struct Contact {
    let firstName: String
    let lastName: String
    let title: String
    let organization: String
    let email: String
    let phone: String
    let address: String
    let website: String
    let department: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    var displayName: String {
        fullName.uppercased()
    }

    func toVCard() -> String {
        return """
        BEGIN:VCARD
        VERSION:3.0
        FN:\(fullName)
        N:\(lastName);\(firstName);;;
        ORG:\(organization)
        TITLE:\(title)
        EMAIL:\(email)
        TEL:\(phone)
        ADR:;;\(address);;;
        URL:\(website)
        NOTE:\(department)
        END:VCARD
        """
    }
}