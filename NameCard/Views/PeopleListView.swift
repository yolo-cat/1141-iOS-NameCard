import SwiftUI

struct PeopleListView: View {
    // make people mutable so we can add new entries
    @State private var people: [Person] = Person.sampleData

    // sheet presentation state
    @State private var showingAddPerson = false

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

                // Contacts section header with a + button aligned horizontally
                Section(
                    header:
                        HStack {
                            Text("Contacts")
                            Spacer()
                            Button(action: {
                                showingAddPerson = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Add Person")
                        }
                ) {
                    NavigationLink(destination: ContactsListView()) {
                        Text("View All Contacts")
                    }
                }
            }
            .navigationTitle("Directory")
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView { newPerson in
                    // append new person and dismiss sheet
                    people.append(newPerson)
                    showingAddPerson = false
                }
            }
        }
    }

    // MARK: - Subviews

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

    struct ContactsListView: View {
        // 建立一個聯絡人頁面空白視圖
        var body: some View {
            Text("Contacts List View")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .navigationTitle("Contacts")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Add Person View

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var type: PersonType = .student

    // onSave closure to pass the new person back to the caller
    var onSave: (Person) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Full name", text: $name)
                }

                Section("Type") {
                    Picker("Type", selection: $type) {
                        ForEach(PersonType.allCases, id: \.self) { t in
                            Text(t.rawValue.dropLast()).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // You can expand to include contact creation fields here.
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newPerson = Person(
                            name: name.trimmingCharacters(in: .whitespaces), type: type,
                            contact: nil)
                        onSave(newPerson)
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
}
