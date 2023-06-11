//
//  PriorityTag.swift
//  todo
//
//  Created by Pascal Bothner on 29.05.23.
//

import SwiftUI

struct PriorityTag: View {
    var priority: Priority
    
    var body: some View {
        getPriorityTag()
    }
    
    func getPriorityTag() -> Tag {
        switch priority {
            case .high:
                return Tag(text: "Hoch", color: .red)
            case .medium:
                return Tag(text: "Mittel", color: .yellow)
            case .low:
                return Tag(text: "Niedrig", color: Color(red: 0.70, green: 0.84, blue: 1.00))
        }
    }
}

struct PriorityTag_Previews: PreviewProvider {
    static var previews: some View {
        PriorityTag(priority: .low)
    }
}
