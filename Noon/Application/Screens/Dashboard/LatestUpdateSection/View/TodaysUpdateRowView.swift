//
//  ActivityRowView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/08/23.
//

import SwiftUI

struct TodaysUpdateRowView: View {
    var memorize: MemorizeEntity
    var color: Color {
        memorize.memorizeCategory == MemorizeCategory.ziyadah.rawValue ? MemorizeCategory.ziyadah.color : MemorizeCategory.murojaah.color
    }
    var body: some View {
        HStack{
            switch memorize.memorizeCategory {
            case MemorizeCategory.ziyadah.rawValue:
                ziyadahRowView
            case MemorizeCategory.murojaah.rawValue:
                switch memorize.murojaahCategory {
                case MurojaahAmountOptions.perPage.rawValue:
                    murojaahPerPageRowView
                case MurojaahAmountOptions.perJuz.rawValue:
                    murojaahPerJuzRowView
                default:
                    EmptyView()
                }
            default:
                EmptyView()
            }
        }
    }
    private var ziyadahRowView: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                dateAndTimeView
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .font(.caption)
                    .textCase(.uppercase)
                Text("Juz \(memorize.key), Page \(memorize.value)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
        }
    }
    private var murojaahPerPageRowView: some View {
        HStack (alignment: .bottom) {
            VStack (alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                dateAndTimeView
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory) | \(memorize.murojaahCategory)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .font(.caption)
                    .textCase(.uppercase)
                Text("Juz \(memorize.key), Page \(memorize.value)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
        }
    }
    private var murojaahPerJuzRowView: some View {
        HStack (alignment: .bottom) {
            VStack (alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                dateAndTimeView
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory) | \(memorize.murojaahCategory)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                    .font(.caption)
                    .textCase(.uppercase)
                Text("\(memorize.key), Juz : \(memorize.value)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
        }
    }
    private var dateAndTimeView: some View {
        HStack (alignment: .top) {
            Text(memorize.createdAt , style: .date)
                .font(.footnote)
                .opacity(0.5)
            Text(memorize.createdAt , style: .time)
                .font(.footnote)
                .opacity(0.5)
        }
    }
}
