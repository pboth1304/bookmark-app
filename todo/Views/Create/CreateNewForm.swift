//
//  CreateNewForm.swift
//  todo
//
//  Created by Pascal Bothner on 06.06.23.
//

import SwiftUI

struct CreateNewForm: View {
    @Binding var isOpen: Bool
    var bookmarkToEdit: Bookmark?
    
    @State private var title: String
    @State private var dueDate = Date()
    @State private var priority: Priority = .low
    @State private var tags = ""
    @State private var description = ""
    @State private var link = ""
    
    @EnvironmentObject var bookmarkStore: BookmarkStore
    
    func dismissSelf() {
        isOpen.toggle()
    }
    
    func createBookmarkAndDismiss() async throws {
        let newTags = tags.components(separatedBy: ",")
        
        if bookmarkToEdit == nil {
            let newBookmark = Bookmark(title: title, description: description, dueDate: dueDate, createdAt:  Date(), tags: newTags, link: link, priority: priority)

            _ = try await bookmarkStore.addBookmark(newBookmark: newBookmark)
        } else {
            _ = try await bookmarkStore.updateBookmark(bookmarkId: bookmarkToEdit!.id, title: title, dueDate: dueDate, priority: priority, link: link, tags: newTags, description: description)
        }
        
        dismissSelf()
    }
    
    init(bookmarkToEdit: Bookmark? = nil, isOpen: Binding<Bool>) {
        self.bookmarkToEdit = bookmarkToEdit
        self._isOpen = isOpen
        
        _title = State(initialValue: bookmarkToEdit?.title ?? "")
        _dueDate = State(initialValue: bookmarkToEdit?.dueDate ?? Date())
        _priority = State(initialValue: bookmarkToEdit?.priority ?? .low)
        _link = State(initialValue: bookmarkToEdit?.link ?? "")
        _tags = State(initialValue: bookmarkToEdit?.tags.joined(separator: ", ") ?? "")
        _description = State(initialValue: bookmarkToEdit?.description ?? "")
    }

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Titel", text: $title)
                    DatePicker(
                        "Erinnerungsdatum",
                        selection: $dueDate,
                        displayedComponents: [.date]
                    )
                    Picker("Priorität", selection: $priority) {
                        Text("Hoch").tag(Priority.high)
                        Text("Mittel").tag(Priority.medium)
                        Text("Niedrig").tag(Priority.low)
                    }
                    TextField("Link", text: $link)
                    TextField("Tags", text: $tags)
                    TextEditor( text: $description)
                        .frame(height: 100)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen", action: dismissSelf)
                }
                ToolbarItem(placement: .principal) {
                    Text(bookmarkToEdit == nil ? "Lesezeichen erstellen" : bookmarkToEdit!.title + " bearbeiten")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern", action: {
                        Task { try await createBookmarkAndDismiss() }
                    })
                }
            }
        }
    }
}

struct CreateNewForm_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewForm(isOpen: .constant(true))
            .environmentObject(BookmarkStore())
    }
}
