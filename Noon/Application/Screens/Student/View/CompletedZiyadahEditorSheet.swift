//
//  CompletedZiyadahEditorSheet.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 19/07/24.
//

import SwiftUI

struct CompletedZiyadahEditorSheet: View {
    @EnvironmentObject var studentVM: StudentViewModel
    var studentId: UUID
    var completedZiyadah: [CompletedZiyadahEntity]
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(completedZiyadah.sorted { $0.juz < $1.juz }) { juz in
                    CompletedZiyadahItem(
                        juz: String(juz.juz),
                        caption: "\(NSLocalizedString("Complete at", comment: "")) \(DateUtils.getDateOnlyString(date: juz.createdAt))",
                        isCompleted: true,
                        action: {
                            studentVM.deleteCompletedZiyadah(id: juz.id) { res in
                                print(res)
                            }
                        }
                    )
                }
                Divider()
                let completedJuzNumbers = completedZiyadah.map { $0.juz }
                ForEach((1...30).filter { !completedJuzNumbers.contains($0) }, id: \.self) { juz in
                    CompletedZiyadahItem(
                        juz: String(juz),
                        caption: NSLocalizedString("Not Completed", comment: ""),
                        isCompleted: false,
                        action: {
                            studentVM.updateCompletedZiyadah(
                                id: studentId,
                                juz: juz
                            ) { response in
                                print(response)
                            }
                        }
                    )
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .navigationTitle("Total Memorization \(completedZiyadah.count) Juz")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color(UIColor.systemGray6))
    }
}

struct CompletedZiyadahItem: View {
    private let juz: String
    private let caption: String
    private let isCompleted: Bool
    private let action: () -> Void

    init(juz: String, caption: String, isCompleted: Bool, action: @escaping () -> Void) {
        self.juz = juz
        self.caption = caption
        self.isCompleted = isCompleted
        self.action = action
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Juz \(juz)")
                    .font(.headline)
                Text("\(caption)")
                    .font(.caption2)
            }
            Spacer()
            Button("", systemImage: isCompleted ? "checkmark.circle.fill" : "circle") {
                action()
            }
        }
    }
}
