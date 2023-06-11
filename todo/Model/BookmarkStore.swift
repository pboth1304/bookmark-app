//
//  TodoStore.swift
//  todo
//
//  Created by Pascal Bothner on 03.06.23.
//

import Foundation

@MainActor
class BookmarkStore: ObservableObject {
    @Published var bookmarks: [Bookmark] = Bookmark.allBookmarks
    
    var openBookmarks: [Bookmark] {
        return bookmarks.filter { $0.isClosed == false }
    }
    
    var closedBookmarks: [Bookmark] {
        return bookmarks.filter { $0.isClosed == true }
    }

    func load() async throws {
        let task = Task<[Bookmark], Error> {
            let fileURL = try Self.getFileURL()

            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }

            let bookmarks = try JSONDecoder().decode([Bookmark].self, from: data)

            return bookmarks
        }

        let bookmarks = try await task.value

        self.bookmarks = bookmarks
    }
    
    func addBookmark(newBookmark: Bookmark) async throws {
        bookmarks.append(newBookmark)
        _ = try await save(bookmarks: bookmarks)
    }
    
    func updateBookmark(bookmarkId: UUID, title: String, dueDate: Date, priority: Priority, link: String, tags: [String], description: String) async throws {
        let bookmarkIdx = getBookmarkIdxById(bookmarkId: bookmarkId)
        
        if bookmarkIdx != nil {
            bookmarks[bookmarkIdx!].title = title
            bookmarks[bookmarkIdx!].dueDate = dueDate
            bookmarks[bookmarkIdx!].priority = priority
            bookmarks[bookmarkIdx!].link = link
            bookmarks[bookmarkIdx!].tags = tags
            bookmarks[bookmarkIdx!].description = description
            
            _ = try await save(bookmarks: bookmarks)
        }
    }
    
    func deleteBookmark(bookmarkId: UUID) async throws {
        let bookmarkIdx = getBookmarkIdxById(bookmarkId: bookmarkId)
        
        if (bookmarkIdx != nil) {
            bookmarks.remove(at: bookmarkIdx!)
            
            _ = try await save(bookmarks: bookmarks)
        }
    }
    
    func setBookmarkAsDone(bookmarkId: UUID) async throws {
        let bookmarkIdx = getBookmarkIdxById(bookmarkId: bookmarkId)

        if (bookmarkIdx != nil) {
            bookmarks[bookmarkIdx!].isClosed = true
            
            _ = try await save(bookmarks: bookmarks)
        }
    }
    
    private func getBookmarkIdxById(bookmarkId: UUID) -> Int? {
        return bookmarks.firstIndex {
            $0.id == bookmarkId
        }
    }

    private func save(bookmarks: [Bookmark]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(bookmarks)
            let outfile = try Self.getFileURL()

            try data.write(to: outfile)
        }

        _ = try await task.value
    }
    
    private static func getFileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        .appendingPathComponent("bookmarks.data")
    }
}
