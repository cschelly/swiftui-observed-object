//
//  CardImageView.swift
//  ObservableObject
//
//  Created by Christina S on 11/17/19.
//  Copyright © 2019 Schelly. All rights reserved.
//

import SwiftUI

struct CardImageView: View {
    var name: String
    var body: some View {
        Image(name)
        .resizable()
        .frame(width: 300, height: 300)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1)
        )
        .shadow(radius: 7)
    }
}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        CardImageView(name: "shoes")
    }
}
