import SwiftUI

struct PeopleListView: View {
    let people = Person.sampleData
    
    var teachersSorted: [Person] {
        people.filter { $0.type == .teacher }.sorted { $0.name < $1.name }
    }
    
    var studentsSorted: [Person] {
        people.filter { $0.type == .student }.sorted { $0.name < $1.name }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Teachers") {
                    ForEach(teachersSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
                
                Section("Students") {
                    ForEach(studentsSorted) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
            }
            .navigationTitle("Directory")
        }
    }
}

struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                Text(person.type.rawValue.dropLast())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if person.contact != nil {
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.blue)
            }
        }
        .padding(.vertical, 2)
    }
}

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        Group {
            if let contact = person.contact {
                HarryView(contact: contact)
            } else {
                VStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.gray)
                    Text(person.name)
                        .font(.largeTitle)
                        .padding()
                    Text("No name card available")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PeopleListView()
}