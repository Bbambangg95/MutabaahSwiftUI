//
//  UserNewScheduleFormView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/08/23.
//

import SwiftUI

struct UserScheduleEditorView: View {
    @Binding var newTimeLabel: String
    @Binding var newStartTime: Date
    @Binding var newEndTime: Date
    var cancelAction: () -> Void
    var saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Label") {
                    TextField("New Time Label", text: $newTimeLabel)
                        .font(.headline)
                        .textInputAutocapitalization(.words)
                }
                Section ("Time") {
                    DatePicker("Start Time", selection: $newStartTime, displayedComponents: .hourAndMinute)
                        .pickerStyle(.automatic)
                    DatePicker("End Time", selection: $newEndTime, displayedComponents: .hourAndMinute)
                        .pickerStyle(.automatic)
                }
            }
            .navigationTitle("New Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .destructive) {
                        withAnimation {
                            cancelAction()
                        }
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            saveAction()
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}


//struct UserNewScheduleFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserNewScheduleFormView()
//    }
//}
