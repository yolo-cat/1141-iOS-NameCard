//
//  ContactCategory.swift
//  NameCard
//
//  Created by Joseph-M2 on 2025/9/16.
//

import Foundation
import SwiftData

@Model
class ContactCategory {
    var id: UUID
    var name: String
    
    @Relationship(
        deleteRule: .nullify,
        inverse: \StoredContact.category
    )
    
    var contacts: [StoredContact] = []
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
