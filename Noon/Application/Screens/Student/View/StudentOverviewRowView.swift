//
//  StudentOverviewRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 19/08/23.
//

import SwiftUI

struct StudentOverviewRowView: View {
    private let label: String
    private let value: String?
    private let date: Date?
    private let relativeDate: Date?
    init(
        label: String,
        value: String? = nil,
        date: Date? = nil,
        relativeDate: Date? = nil
    )
    {
        self.label = label
        self.value = value
        self.date = date
        self.relativeDate = relativeDate
    }
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            if let stringValue = value {
                Text(stringValue)
                    .foregroundColor(Color.secondary)
                    .multilineTextAlignment(.trailing)
            }
            if let dateValue = date {
                Text(dateValue, style: .date)
                    .foregroundColor(Color.secondary)
            }
            if let relativeDate = relativeDate {
                Text(relativeDate, style: .relative)
                    .foregroundColor(Color.secondary)
            }
        }
    }
}
