//
//  MemorizeListRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import SwiftUI

struct MemorizeListRowView: View {
    var student: StudentEntity
    var body: some View {
        NavigationLink {
            MemorizeEditorScreen(student: student)
        } label: {
            VStack(alignment: .leading) {
                Text(student.name )
                    .font(.headline)
                    .lineLimit(1)
            }
        }
    }
    //
}
