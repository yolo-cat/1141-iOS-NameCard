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
                
//                在Section "Contacts" 文字水平放置一個 ＋ 號按鈕，點擊後顯示一個彈出視窗，讓使用者可以新增聯絡人
                
//                HStack {
//                    Text("Contacts")
//                    Spacer()
//                    Button(action: {
//                        // 新增聯絡人按鈕的動作
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.title2)
//                            .foregroundStyle(.blue)
//                    }
//                }
                Section("Contacts") {
                    NavigationLink(destination: ContactsListView()) {
                        Text("View All Contacts")
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
    
    struct ContactsListView: View {
        //    建立一個聯絡人頁面空白視圖
        var body: some View {
            Text("Contacts List View")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .navigationTitle("Contacts")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PeopleListView()
}
