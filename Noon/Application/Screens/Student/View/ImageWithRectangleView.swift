//
//  ImageWithRectangleView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/08/23.
//

import SwiftUI

struct ImageWithRectangleView: View {
    var imageName: String
    var color: Color
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(.white)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)
            )
    }
}
