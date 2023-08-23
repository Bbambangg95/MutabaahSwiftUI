//
//  AttendanceSectionView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct AttendanceSectionView: View {
    var students: [StudentEntity]
    var title: String
    var imageName: String
    var body: some View {
        Section {
            ForEach(students) { student in
                AttendanceRowView(student: student)
            }
        } header: {
            Text(title)
        }
    }
}
