//
//  UserScheduleListRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/08/23.
//

import SwiftUI

struct UserScheduleListRowView: View {
    let item: UserScheduleEntity?
    let deleteAction: () -> Void
    let editAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item?.timeLabel ?? "")
                .font(.headline)
            Text("\(item?.startTime ?? Date(), style: .time) to \(item?.endTime ?? Date(), style: .time)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                withAnimation {
                    deleteAction()
                }
            } label: {
                Image(systemName: "trash")
            }
            Button {
                withAnimation {
                    editAction()
                }
            } label: {
                Image(systemName: "square.and.pencil")
            }
            .tint(.gray)
        }
    }
}
//
//struct UserScheduleListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserScheduleListRowView()
//    }
//}
