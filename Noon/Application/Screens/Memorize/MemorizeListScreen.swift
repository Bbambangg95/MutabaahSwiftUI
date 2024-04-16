//
//  AddMemorizeView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 14/07/23.
//

import SwiftUI

struct MemorizeListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var presentSummaryZiyadah: Bool = false
    @State private var adsOrSubscribe: Bool = false
    @State private var watchAds: Bool = false
    var interstitialAds: InterstitialAd
    init() {
        self.interstitialAds = InterstitialAd()
    }
    var body: some View {
        NavigationStack {
            List {
                if !SubscriptionManager.shared.isSubscribed {
                    AdBannerView()
                }
                ForEach(studentVM.students.sorted { $0.name < $1.name}) { student in
                    MemorizeListRowView(student: student)
                }
            }
            .sheet(
                isPresented: $adsOrSubscribe,
                onDismiss: {
                    if watchAds {
                        interstitialAds.showAd()
                        interstitialAds.setOnAdDismissed {
                            watchAds = false
                            presentSummaryZiyadah.toggle()
                        }
                    }
                }
            ) {
                AdsOrSubsView {
                    adsOrSubscribe.toggle()
                    watchAds = true
                }
            }
            .sheet(isPresented: $presentSummaryZiyadah) {
                SummaryZiyadah(students: studentVM.students)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Memorization")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if !SubscriptionManager.shared.isSubscribed {
                            adsOrSubscribe.toggle()
                        } else {
                            presentSummaryZiyadah.toggle()
                        }
                    } label: {
                        Image(systemName: "chart.bar.xaxis")
                    }
                }
            }
            
        }
    }
}
