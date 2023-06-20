//
//  TodoDetails.swift
//  todo
//
//  Created by Pascal Bothner on 21.05.23.
//

import SwiftUI

struct BookmarkDetails: View {
    @EnvironmentObject var bookmarkStore: BookmarkStore
    @Environment(\.presentationMode) var presentationMode
        
    @State private var showEditDialog = false
    
    var bookmarkId: UUID
    
    var activeBookmark: Bookmark? {
        let idx = bookmarkStore.bookmarks.firstIndex{$0.id == bookmarkId}
        
        if idx != nil {
            return bookmarkStore.bookmarks[idx!]
        } else {
            return nil
        }
    }
    
    func deleteBookmark() async throws {
        _ = try await bookmarkStore.deleteBookmark(bookmarkId: bookmarkId)
        presentationMode.wrappedValue.dismiss() // Navigates back
    }
    
    func setAsDone() async throws {
       try await bookmarkStore.setBookmarkAsDone(bookmarkId: bookmarkId)
    }
    
    func edit() {
        showEditDialog.toggle()
    }
    
    var body: some View {
        if activeBookmark != nil { // TODO: better type casting
            NavigationStack {
                VStack(alignment: .leading, spacing: 30) {
                    BookmarkMetadata(bookmark: activeBookmark!)
                    Text(activeBookmark!.description)
                        .frame(width: .infinity, alignment: .leading)
                    Spacer()
                }
                .navigationTitle(activeBookmark!.title)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            if !(activeBookmark?.isClosed ?? false) {
                                Button("Abschließen", action:  {
                                    Task { try await setAsDone() }
                                })
                                    .buttonStyle(.bordered)
                                    .tint(.green)
                                
                                Menu {
                                    Button(action: edit) {
                                        Label("Bearbeiten", systemImage: "pencil")
                                            .labelStyle(DefaultLabelStyle())
                                    }
                                    Button(action: {
                                        Task { try await deleteBookmark() }
                                    }) {
                                        Label("Löschen", systemImage: "trash")
                                            .labelStyle(DefaultLabelStyle())
                                    }
                                } label: {
                                   Label("Options", systemImage: "ellipsis")
                               }
                            } else {
                                Button("Löschen", action:  {
                                    Task { try await deleteBookmark() }
                                })
                                    .buttonStyle(.bordered)
                                    .tint(.red)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showEditDialog) {
                    CreateNewForm(bookmarkToEdit: activeBookmark, isOpen: $showEditDialog)
                }
            }
        } else {
            Text("Lesezeichen mit UUID " + bookmarkId.uuidString + " kann nicht gefunden werden.")
                .foregroundColor(.red)
        }
    }
}

struct BookmarkDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkDetails(bookmarkId: Bookmark.allBookmarks[0].id)
            .environmentObject(BookmarkStore())
    }
}
