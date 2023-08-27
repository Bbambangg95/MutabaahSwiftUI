//
//  Last30DaysRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/08/23.
//

import SwiftUI

struct SummaryRowView<DestinationView: View>: View {
    var destination: DestinationView
    var imageName: String
    var title: String
    var color: Color
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName)
                    .font(.title)
                    .foregroundColor(color)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }
}

