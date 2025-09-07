import Foundation

enum PersonType: String, CaseIterable {
    case teacher = "Teachers"
    case student = "Students"
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let type: PersonType
    let contact: Contact?
    
    init(name: String, type: PersonType, contact: Contact? = nil) {
        self.name = name
        self.type = type
        self.contact = contact
    }
}

extension Person {
    static let sampleData: [Person] = [
        Person(name: "Harry", type: . teacher, contact: Contact.sampleData)
    ]
}
