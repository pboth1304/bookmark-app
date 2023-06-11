//
//  TodoList.swift
//  todo
//
//  Created by Pascal Bothner on 14.05.23.
//

import SwiftUI

struct BookmarkList: View {
    @EnvironmentObject var bookmarksStore: BookmarkStore
        
    @State private var showCreateBookmarkDialog = false
    @State private var searchQuery = ""
    
    var openBookmarkSearchResults: [Bookmark] {
        if searchQuery.isEmpty {
            return bookmarksStore.openBookmarks
        } else {
            return bookmarksStore.openBookmarks.filter { $0.title.contains(searchQuery) || $0.description.contains(searchQuery)
            }
        }
    }
    
    var closedBookmarkSearchResults: [Bookmark] {
        if searchQuery.isEmpty {
            return bookmarksStore.closedBookmarks
        } else {
            return bookmarksStore.closedBookmarks.filter { $0.title.contains(searchQuery) || $0.description.contains(searchQuery)
            }
        }
    }
    
    func openAddNewBookmarkDialog() {
        showCreateBookmarkDialog.toggle()
    }
        
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Offen (" + String(openBookmarkSearchResults.count) + ")")
                ) {
                    ForEach(openBookmarkSearchResults) { bookmark in
                        NavigationLink {
                            BookmarkDetails(bookmarkId: bookmark.id)
                        } label: {
                            BookmarkItem(bookmark: bookmark)
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { idx in
                            let bookmarkToRemove = bookmarksStore.openBookmarks[idx]
                        
                            Task {
                                try await bookmarksStore.deleteBookmark(bookmarkId: bookmarkToRemove.id)
                            }
                        }
                    }
                }
                
                Section(
                    header: Text("Geschlossen (" + String(closedBookmarkSearchResults.count) + ")")
                ) {
                    ForEach(closedBookmarkSearchResults) { bookmark in
                        NavigationLink {
                            BookmarkDetails(bookmarkId: bookmark.id)
                        } label: {
                            BookmarkItem(bookmark: bookmark)
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { idx in
                            let bookmarkToRemove = bookmarksStore.closedBookmarks[idx]
                        
                            Task {
                                try await bookmarksStore.deleteBookmark(bookmarkId: bookmarkToRemove.id)
                            }
                        }
                    }
                }
            }
                .navigationTitle("Deine Merkliste")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: openAddNewBookmarkDialog) {
                            Label("Neu", systemImage: "plus")
                                .labelStyle(TitleAndIconLabelStyle())
                        }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                            .sheet(isPresented: $showCreateBookmarkDialog) {
                                CreateNewForm(isOpen: $showCreateBookmarkDialog)
                            }
                    }
                }
                .listStyle(.sidebar)
            
        }.searchable(text: $searchQuery)
    }
}

struct BookmarkList_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkList()
            .environmentObject(BookmarkStore())
    }
}
