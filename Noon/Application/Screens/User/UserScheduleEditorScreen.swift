//
//  UserScheduleEditorScreen.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 06/08/23.
//

import SwiftUI

struct UserScheduleEditorScreen: View {
    @EnvironmentObject var userScheduleVM: UserScheduleViewModel
    @State private var isAdding: Bool = false
    @State private var isEditing: Bool = false
    @State private var isDeleting: Bool = false
    @State var editedScheduleId: UUID = UUID()
    var body: some View {
        List {
            Section {
                ForEach(userScheduleVM.userSchedule) { item in
                        UserScheduleListRowView(
                            item: item) {
                                isDeleting = true
                                editedScheduleId = item.id
                            } editAction: {
                                userScheduleVM.startEditing(schedule: item)
                                editedScheduleId = item.id
                                isAdding = true
                                isEditing = true
                            }
                }
            }
        }
        .alert("Delete Schedule", isPresented: $isDeleting) {
            Button(role: .destructive) {
                userScheduleVM.deleteUserSchedule(id: editedScheduleId)
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {
                // Do nothing, cancel the deletion process
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("By deleting this schedule, all associated data will be permanently removed.")
        }
        .toolbar {
            Button {
                withAnimation {
                    userScheduleVM.startEditing(schedule: nil)
                    isAdding.toggle()
                }
            } label: {
                Image(systemName: "plus")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAdding, onDismiss: hideSheet , content: {
            UserScheduleEditorView(
                newTimeLabel: $userScheduleVM.timeLabel,
                newStartTime: $userScheduleVM.startTime,
                newEndTime: $userScheduleVM.endTime,
                cancelAction: {
                    isAdding = false
                },
                saveAction: {
                    if isEditing{
                        userScheduleVM.updateUserSchedule(id: editedScheduleId)
                    } else {
                        userScheduleVM.createUserSchedule()
                    }
                    isAdding = false
                    isEditing = false
                })
        })
    }
    private func hideSheet() {
        isAdding = false
    }
}
