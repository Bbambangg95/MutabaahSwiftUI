//
//  ProgressHistorySheet.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 27/08/23.
//

import SwiftUI

struct ProgressHistorySheet: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var selectedCategory: String = MemorizeCategory.ziyadah.rawValue
    @State private var isDelete: Bool = false
    @State private var itemToDelete: ZiyadahEntity?
    private let ziyadahData: [ZiyadahEntity]?
    private let murojaahData: [MurojaahEntity]?
    init(ziyadahData: [ZiyadahEntity]? = nil, murojaahData: [MurojaahEntity]? = nil) {
        self.ziyadahData = ziyadahData
        self.murojaahData = murojaahData
    }
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $selectedCategory) {
                    ForEach(MemorizeCategory.allCases, id:\.self) { item in
                        Text(item.rawValue).tag(item.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                List {
                    switch selectedCategory {
                    case MemorizeCategory.ziyadah.rawValue:
                        ziyadahRowView
                    case MemorizeCategory.murojaah.rawValue:
                        murojaahRowView
                    default:
                        EmptyView()
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
            }
            .padding(.horizontal)
            .navigationTitle("Memorization History")
            .navigationBarTitleDisplayMode(.inline)
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
                Text("You are about to delete Page \(itemToDelete?.page ?? 0) and all pages after it in the same Juz. Are you sure you want to proceed?")
            }
        }
        .background(Color(UIColor.systemGray6))
    }
    func groupZiyadahByMonth(ziyadahData: [ZiyadahEntity]) -> [(String, [ZiyadahEntity])] {
        let grouped = Dictionary(grouping: ziyadahData) { $0.createdAt.toMonthYearString() }
        return grouped.map { (key, value) in (key, value) }
            .sorted { $0.0 > $1.0 }
    }
    private var ziyadahRowView: some View {
        let groupedData = groupZiyadahByMonth(ziyadahData: ziyadahData ?? [])

        return ForEach(groupedData, id: \.0) { (month, items) in
            Section(header: Text("\(month) - \(items.count) times")) {
                ForEach(items) { item in
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("Juz \(item.juz) Page \(item.page)")
                                .font(.subheadline)
                            HStack {
                                Text(item.createdAt, style: .date)
                                Text(item.createdAt, style: .time)
                            }
                            .font(.footnote)
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
                }
            }
        }
    }
    func groupMurojaahByMonth(murojaahData: [MurojaahEntity]) -> [(String, [MurojaahEntity])] {
        let grouped = Dictionary(grouping: murojaahData) { $0.createdAt.toMonthYearString() }
        return grouped.map { (key, value) in (key, value) }
            .sorted { $0.0 > $1.0 }
    }
    private var murojaahRowView: some View {
        let groupedData = groupMurojaahByMonth(murojaahData: murojaahData ?? [])

        return ForEach(groupedData, id: \.0) { (month, items) in
            Section(header: Text("\(month) - \(items.count) times")) {
                ForEach(items) { item in
                    switch item.category {
                    case MurojaahAmountOptions.perPage.rawValue:
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text("Juz \(item.key) Page \(item.value)")
                                    .font(.subheadline)
                                HStack {
                                    Text(item.createdAt, style: .date)
                                    Text(item.createdAt, style: .time)
                                }
                                .font(.footnote)
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
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                Text("\(item.key) (\(item.value))")
                                    .font(.subheadline)
                                HStack {
                                    Text(item.createdAt, style: .date)
                                    Text(item.createdAt, style: .time)
                                }
                                .font(.footnote)
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
            }
        }
    }
}
