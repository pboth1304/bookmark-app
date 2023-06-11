//
//  TodoApp.swift
//  todo
//
//  Created by Pascal Bothner on 14.05.23.
//

import SwiftUI

@main
struct BookmarkApp: App {
    @StateObject private var bookmarkStore = BookmarkStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkStore)
                .task {
                    do {
                        try await bookmarkStore.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }

                }
        }
    }
}
