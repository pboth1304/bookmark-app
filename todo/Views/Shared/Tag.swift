//
//  Tag.swift
//  todo
//
//  Created by Pascal Bothner on 15.05.23.
//

import SwiftUI

struct Tag: View {
    var text: String
    var color: Color = .blue
    
    var body: some View {
        Text(text)
            .padding(.leading, 7)
            .padding(.trailing, 7)
            .padding(.top, 3)
            .padding(.bottom, 3)
            .background(color)
            .cornerRadius(25)
            .font(.system(size: 14))
            .bold()
            .foregroundColor(.white)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(text: "12")
    }
}
