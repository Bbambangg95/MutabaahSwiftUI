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
            imageView
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
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
        .padding(.vertical, 1)
    }
    private var imageView: some View {
        Image(systemName: memorize.memorizeCategory == MemorizeCategory.ziyadah.rawValue ? "bookmark.square" : "arrow.2.squarepath")
            .font(.title2)
            .scaledToFill()
            .foregroundColor(color)
    }
    private var ziyadahRowView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                Text("Juz \(memorize.key), Page \(memorize.value)")
                    .font(.footnote)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory)")
                dateAndTimeView
            }
        }
    }
    private var murojaahPerPageRowView: some View {
        HStack (alignment: .top) {
            VStack (alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                Text("Juz \(memorize.key), Page \(memorize.value)")
                    .font(.footnote)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory) | \(memorize.murojaahCategory)")
                dateAndTimeView
            }
        }
    }
    private var murojaahPerJuzRowView: some View {
        HStack (alignment: .top) {
            VStack (alignment: .leading) {
                Text("\(memorize.studentName)")
                    .font(.headline)
                    .lineLimit(1)
                Text("\(memorize.key), Juz : \(memorize.value)")
                    .font(.footnote)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(memorize.memorizeCategory) | \(memorize.murojaahCategory)")
                dateAndTimeView
            }
        }
    }
    private var dateAndTimeView: some View {
        HStack (alignment: .top) {
            Spacer()
            Text(memorize.createdAt , style: .date)
                .font(.footnote)
                .opacity(0.5)
            Text(memorize.createdAt , style: .time)
                .font(.footnote)
                .opacity(0.5)
        }
    }
}
