//
//  TodoItem.swift
//  todo
//
//  Created by Pascal Bothner on 15.05.23.
//

import SwiftUI

struct BookmarkItem: View {
    var bookmark: Bookmark
        
    var body: some View {
        VStack(alignment: .leading) {
            if (bookmark.isClosed) {
                Text(bookmark.title)
                    .bold()
                    .italic()
                    .foregroundColor(.gray)
                Text(bookmark.description)
                    .multilineTextAlignment(.trailing)
                    .italic()
                    .foregroundColor(.gray)
            } else {
                Text(bookmark.title)
                    .bold()
                Text(bookmark.description)
                    .multilineTextAlignment(.trailing)
            }
            HStack {
                TagRow(tags: bookmark.tags)
                Spacer()
                PriorityTag(priority: bookmark.priority)
            }.frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .padding(.top, 5)
        .padding(.bottom, 5)
    }
}


struct BookmarkItem_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkItem(bookmark: Bookmark.allBookmarks[0])
    }
}
