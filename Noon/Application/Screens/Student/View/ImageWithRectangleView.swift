//
//  ImageWithRectangleView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/08/23.
//

import SwiftUI

struct ImageWithRectangleView: View {
    private let imageName: String
    private let color: Color
    init(imageName: String, color: Color) {
        self.imageName = imageName
        self.color = color
    }
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
