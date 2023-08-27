//
//  Last30DaysRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/08/23.
//

import SwiftUI

struct Last30DaysRowView<DestinationView: View>: View {
    var destination: DestinationView
    var imageName: String
    var title: String
    var data: String
    var color: Color
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Image(systemName: imageName)
                    .font(.title)
                    .foregroundColor(color)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text(data)
                        .font(.caption)
                }
                .foregroundColor(Color.black)
            }
        }
    }
}
