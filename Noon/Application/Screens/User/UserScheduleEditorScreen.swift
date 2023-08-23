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
    @State var editedScheduleId: UUID = UUID()
    var body: some View {
        List {
            Section {
                ForEach(userScheduleVM.userSchedule) { item in
                        UserScheduleListRowView(
                            item: item) {
                                userScheduleVM.deleteUserSchedule(id: item.id)
                            } editAction: {
                                userScheduleVM.startEditing(schedule: item)
                                editedScheduleId = item.id
                                isAdding = true
                                isEditing = true
                            }
                }
            } header: {
                Text("Latest")
            }
        }
        .toolbar {
            Button {
                withAnimation {
                    userScheduleVM.startEditing(schedule: nil)
                    isAdding = true
                }
            } label: {
                Image(systemName: "plus")
            }
        }
        .listStyle(.insetGrouped)
        .toolbarRole(.editor)
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAdding, content: {
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
}

//struct UserScheduleEditorScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        UserScheduleEditorScreen()
//    }
//}
