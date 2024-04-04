//
//  MemorizeListRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 05/08/23.
//

import SwiftUI

struct MemorizeListRowView: View {
    var student: StudentEntity
    var latestZiyadah: ZiyadahEntity? {
        student.ziyadahData.sorted { $0.createdAt < $1.createdAt }.last
    }
    var latestMurojaah: MurojaahEntity? {
        student.murojaahData.sorted { $0.createdAt < $1.createdAt }.last
    }
    var isZiyadahLatest: Bool {
        guard let ziyadahDate = latestZiyadah?.createdAt, let murojaahDate = latestMurojaah?.createdAt else {
            return false
        }
        return ziyadahDate > murojaahDate
    }
    var body: some View {
        NavigationLink {
            MemorizeEditorScreen(student: student)
        } label: {
            VStack(alignment: .leading) {
                Text(student.name )
                    .font(.headline)
                    .lineLimit(1)
                ZiyadahMurojaahView(latestZiyadah: latestZiyadah, latestMurojaah: latestMurojaah, isZiyadahLatest: isZiyadahLatest)
            }
        }
    }
    //
}

struct ZiyadahMurojaahView: View {
    let latestZiyadah: ZiyadahEntity?
    let latestMurojaah: MurojaahEntity?
    let isZiyadahLatest: Bool

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "clock.arrow.circlepath")
                .foregroundStyle(Color.blue)
            content
        }
        .lineLimit(1)
        .font(.subheadline)
    }

    @ViewBuilder
    private var content: some View {
        if let latestZiyadah = latestZiyadah, let latestMurojaah = latestMurojaah {
            if isZiyadahLatest {
                ziyadahContent(latestZiyadah)
            } else {
                murojaahContent(latestMurojaah)
            }
        } else if let latestZiyadah = latestZiyadah {
            ziyadahContent(latestZiyadah)
        } else if let latestMurojaah = latestMurojaah {
            murojaahContent(latestMurojaah)
        } else {
            Text("No data")
        }
    }

    private func ziyadahContent(_ ziyadah: ZiyadahEntity) -> some View {
        HStack(alignment: .center) {
            Text("Ziyadah, Juz \(ziyadah.juz) Page \(ziyadah.page)")
            Spacer()
            HStack(spacing: 2) {
                Text(ziyadah.createdAt, style: .relative)
                Text("ago")
            }
            .font(.caption2)
        }
    }

    private func murojaahContent(_ murojaah: MurojaahEntity) -> some View {
        HStack(alignment: .center) {
            Text(murojaah.category == MurojaahAmountOptions.perJuz.rawValue ? "Murojaah \(murojaah.category) \(murojaah.key)" : "Murojaah \(murojaah.category) (Juz \(murojaah.key) Page \(murojaah.value))")
            Spacer()
            HStack(spacing: 2) {
                Text(murojaah.createdAt, style: .relative)
                Text("ago")
            }
                .font(.caption2)
        }
    }
}
