import SwiftUI
import SwiftData

struct PeopleListView: View {
    @Environment(\.modelContext) private var modelContext

    // Query for SwiftData contacts
    @Query(sort: \StoredContact.name) private var contacts: [StoredContact]

    // Keep static data for Teachers and Students
    @State private var people: [Person] = Person.sampleData

    // sheet presentation state for adding a contact
    @State private var showingAddContact = false

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

                // Contacts section now displays contacts directly
                Section(
                    header:
                        HStack {
                            Text("Contacts")
                            Spacer()
                            Button(action: {
                                showingAddContact = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Add Contact")
                        }
                ) {
                    ForEach(contacts) { contact in
                        VStack(alignment: .leading) {
                            Text(contact.name)
                                .font(.headline)
                            Text(contact.title)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(contact.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteContacts)
                }
            }
            .navigationTitle("Directory")
            .sheet(isPresented: $showingAddContact) {
                AddContactView()
            }
        }
    }

    private func deleteContacts(at offsets: IndexSet) {
        for offset in offsets {
            let contact = contacts[offset]
            modelContext.delete(contact)
        }
    }

    // MARK: - Subviews for static data

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
}

// MARK: - SwiftData-powered Contact Views

struct AddContactView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name: String = ""
    @State private var title: String = ""
    @State private var email: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Contact Details") {
                    TextField("Full name", text: $name)
                    TextField("Title", text: $title)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }

            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newContact = StoredContact(
                            name: name.trimmingCharacters(in: .whitespaces),
                            title: title.trimmingCharacters(in: .whitespaces),
                            email: email.trimmingCharacters(in: .whitespaces)
                        )
                        modelContext.insert(newContact)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    PeopleListView()
        .modelContainer(for: StoredContact.self, inMemory: true)
}
