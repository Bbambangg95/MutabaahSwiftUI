//
//  NavigationWithIconView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/08/23.
//

import SwiftUI

struct NavigationWithIconView<DestinationView: View>: View {
    var destination: DestinationView
    var imageName: String
    var label: String

    var body: some View {
        NavigationLink {
            destination
        } label: {
            Image(systemName: imageName)
            Text(label)
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "chevron.right")
                .font(.caption)
        }
    }
}

