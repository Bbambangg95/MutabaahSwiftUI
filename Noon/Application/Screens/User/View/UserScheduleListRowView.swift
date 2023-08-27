//
//  UserScheduleListRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/08/23.
//

import SwiftUI

struct UserScheduleListRowView: View {
    private let item: UserScheduleEntity?
    private let deleteAction: () -> Void
    private let editAction: () -> Void
    
    init(item: UserScheduleEntity?, deleteAction: @escaping () -> Void, editAction: @escaping () -> Void) {
        self.item = item
        self.deleteAction = deleteAction
        self.editAction = editAction
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item?.timeLabel ?? "")
                .font(.headline)
            Text("\(item?.startTime ?? Date(), style: .time) to \(item?.endTime ?? Date(), style: .time)")
                .font(.subheadline)
                .foregroundColor(Color.gray)
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
