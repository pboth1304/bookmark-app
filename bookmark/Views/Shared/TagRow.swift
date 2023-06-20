//
//  TagRow.swift
//  todo
//
//  Created by Pascal Bothner on 21.05.23.
//

import SwiftUI

struct TagRow: View {
    var tags: [String]
    
    var body: some View {
        HStack {
            ForEach(tags.prefix(3), id: \.self) { tag in
                Tag(text: tag)
            }
            if(tags.count > 3) {
                Tag(text: "+" + String(tags.count - 3))
            }
        }
    }
}

struct TagRow_Previews: PreviewProvider {
    static var previews: some View {
        TagRow(tags: ["Test", "Test 2", "Test 3", "Test 4"])
    }
}
