//
//  StoredContact.swift
//  NameCard
//
//  Created by Joseph-M2 on 2025/9/16.
//

import Foundation
import SwiftData

@Model
class StoredContact {
    var id: UUID
    var name: String
    var title: String
    var email: String
    
    var category: ContactCategory?
    
    init(id: UUID = UUID(), name: String, title: String, email: String) {
        self.id = id
        self.name = name
        self.title = title
        self.email = email
    }
}
