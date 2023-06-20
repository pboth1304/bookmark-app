//
//  Todo.swift
//  todo
//
//  Created by Pascal Bothner on 18.05.23.
//

import Foundation

enum Priority: String, Encodable, Decodable {
    case high, medium, low
}

struct Bookmark: Hashable, Identifiable, Encodable, Decodable {
    var id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var createdAt: Date
    var isClosed: Bool = false
    var tags: [String]
    var link: String
    var priority: Priority
}

extension Bookmark {
    static let allBookmarks = [
        Bookmark(title: "Todo 1", description: "Lorem ipsum", dueDate: Date.now, createdAt: Date.now, tags: ["Büro"], link: "www.google.de", priority: Priority.high),
        Bookmark(title: "Todo 2", description: "Lorem ipsum dolor", dueDate: Date(), createdAt: Date(), tags: ["Hugo"], link: "www.google.de", priority: Priority.low),
        Bookmark(title: "Todo 3", description: "Lorem ipsum aga", dueDate: Date(), createdAt: Date(), tags: ["Büro", "Projekt", "AG 2", "UI"], link: "www.google.de", priority: Priority.high),
        Bookmark(title: "Todo 4", description: "Lorem", dueDate: Date(), createdAt: Date(), tags: ["Büro"], link: "www.google.de", priority: Priority.medium),
        Bookmark(title: "Todo 5", description: "Lorem ipsum aga g ogam gaoakgagm", dueDate: Date(), createdAt: Date(), isClosed: true, tags: ["Privat"], link: "www.google.de", priority: Priority.high)
    ]
}
