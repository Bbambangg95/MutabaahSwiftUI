//
//  StudentOverviewRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 19/08/23.
//

import SwiftUI

struct StudentOverviewRowView: View {
    var label: String
    var value: String?
    var date: Date?
    var relativeDate: Date?
    var imageName: String
    var color: Color
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(color)
                )
            Text(label)
            Spacer()
            if let stringValue = value {
                Text(stringValue)
            }
            if let dateValue = date {
                Text(dateValue, style: .date)
            }
            if let relativeDate = relativeDate {
                Text(relativeDate, style: .relative)
            }
        }
    }
}
