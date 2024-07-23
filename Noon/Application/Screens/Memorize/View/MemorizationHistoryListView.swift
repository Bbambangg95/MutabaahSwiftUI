//
//  MemorizationHistoryListView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 20/07/24.
//

import SwiftUI

struct ZiyadahHistoryItemView: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var isDelete: Bool = false
    @State private var itemToDelete: ZiyadahEntity?
    private let ziyadahData: [ZiyadahEntity]?
    init(ziyadahData: [ZiyadahEntity]?) {
        self.ziyadahData = ziyadahData
    }
    var body: some View {
        ForEach(ziyadahData?.sorted(by: { $0.createdAt > $1.createdAt }) ?? []) { item in
            HStack(alignment: .center) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.headline)
                VStack(alignment: .leading) {
                    Text("Juz \(item.juz) Page \(item.page)")
                        .font(.subheadline)
                    HStack {
                        Text(item.createdAt , style: .date)
                        Text(item.createdAt , style: .time)
                    }
                    .italic()
                    .font(.caption2)
                    .foregroundColor(Color.secondary)
                }
                Spacer()
                HStack(alignment: .top) {
                    HStack {
                        Image(systemName: "hearingdevice.ear")
                        Text("\(item.memorizeValue)")
                    }
                    .padding(.trailing, 4)
                    HStack {
                        Image(systemName: "mic")
                        Text("\(item.recitationValue)")
                    }
                }
                .font(.subheadline)
            }
            .swipeActions(edge: .trailing) {
                Button {
                    isDelete.toggle()
                    itemToDelete = item
                } label: {
                    Image(systemName: "trash")
                }
                .tint(Color.red)
            }
            .alert("Delete", isPresented: $isDelete) {
                Button(role: .destructive) {
                    withAnimation {
                        ZiyadahViewModel.deleteZiyadah(
                            id: itemToDelete?.id ?? UUID(),
                            ziyadahData: ziyadahData ?? []
                        )
                    }
                    studentVM.fetchStudents()
                } label: {
                    Text("Delete")
                }
            } message: {
                Text("You are about to delete Page \(itemToDelete?.page ?? 0). Are you sure you want to proceed?")
            }
        }
        .listRowSeparatorTint(Color.gray)
        .listRowBackground(Color.clear)
        .foregroundStyle(Color.black.opacity(0.7))
    }
}

struct MurojaahHistoryItemView: View {
    @EnvironmentObject var studentVM: StudentViewModel
    private let murojaahData: [MurojaahEntity]?
    init(murojaahData: [MurojaahEntity]?) {
        self.murojaahData = murojaahData
    }
    var body: some View {
            ForEach(murojaahData?.sorted(by: { $0.createdAt > $1.createdAt }) ?? []) { item in
                switch item.category {
                case MurojaahAmountOptions.perPage.rawValue:
                    HStack(alignment: .center) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.headline)
                        VStack(alignment: .leading) {
                            Text("Juz \(item.key) Page \(item.value)")
                                .font(.subheadline)
                            HStack {
                                Text(item.createdAt , style: .date)
                                Text(item.createdAt , style: .time)
                            }
                            .italic()
                            .font(.caption2)
                            .foregroundColor(Color.secondary)
                        }
                        Spacer()
                        HStack(alignment: .top) {
                                Image(systemName: "book")
                                Text("\(item.category)")
                        }
                        .font(.subheadline)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            withAnimation {
                                MurojaahViewModel.deleteMurojaah(id: item.id)
                                studentVM.fetchStudents()
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(Color.red)
                    }
                case MurojaahAmountOptions.perJuz.rawValue:
                    HStack(alignment: .center) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.headline)
                        VStack(alignment: .leading) {
                            Text("\(item.key) (\(item.value))")
                                .font(.subheadline)
                            HStack {
                                Text(item.createdAt , style: .date)
                                Text(item.createdAt , style: .time)
                            }
                            .italic()
                            .font(.caption2)
                            .foregroundColor(Color.secondary)
                        }
                        Spacer()
                        HStack {
                                Image(systemName: "books.vertical")
                                Text("\(item.category)")
                        }
                        .font(.subheadline)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            withAnimation {
                                MurojaahViewModel.deleteMurojaah(id: item.id)
                                studentVM.fetchStudents()
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(Color.red)
                    }
                default:
                    EmptyView()
                }
            }
        .listRowSeparatorTint(Color.gray)
        .listRowBackground(Color.clear)
        .foregroundStyle(Color.black.opacity(0.7))
        }
    }
