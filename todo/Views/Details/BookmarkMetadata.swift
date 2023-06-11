//
//  TodoMetadata.swift
//  todo
//
//  Created by Pascal Bothner on 27.05.23.
//

import SwiftUI

struct BookmarkMetadata: View {
    var bookmark: Bookmark
    
    var labelWidth = CGFloat(120)

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Fällig am")
                    .frame(width: labelWidth, alignment: .leading)
                Text(DateUtils.getGermanDateFormat(date: bookmark.dueDate, includeTime: true))
                Spacer()
            }
            Divider()
            HStack {
                Text("Status")
                    .frame(width: labelWidth, alignment: .leading)
                Text(bookmark.isClosed ? "Geschlossen" : "Offen")
                Spacer()
            }
            Divider()
            HStack {
                Text("Priorität")
                    .frame(width: labelWidth, alignment: .leading)
                PriorityTag(priority: bookmark.priority)
                Spacer()
            }
            Divider()
            HStack {
                Text("Link")
                    .frame(width: labelWidth, alignment: .leading)
                Text(bookmark.link)
                Spacer()
            }
            Divider()
            HStack {
                Text("Tags")
                    .frame(width: labelWidth, alignment: .leading)
                TagRow(tags: bookmark.tags)
                Spacer()
            }
            Divider()
        }
    }
}

struct BookmarkMetadata_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkMetadata(bookmark: Bookmark.allBookmarks[0])
    }
}
