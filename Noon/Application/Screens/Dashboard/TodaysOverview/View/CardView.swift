//
//  InfoView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct CardView: View {
    var number: Int
    var title: String
    var color: Color
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title2)
                .scaledToFill()
                .foregroundColor(color)
                .padding(6)
                .background(
                    Circle()
                        .foregroundColor(color.opacity(0.2))
                )
            VStack(alignment: .leading) {
                Text("\(number)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
