//
//  AdsOrSubsView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 09/04/24.
//

import SwiftUI

struct AdsOrSubsView: View {
    var buttonAction: () -> Void
    var body: some View {
        VStack {
            SubscriptionView()
            VStack {
                Text("Or you can access this feature once by watching an advertisement.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .italic()
                    .foregroundStyle(Color.green)
                Button {
                    buttonAction()
                } label: {
                    Label("Watch Ad", systemImage: "movieclapper")
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.orange)
                )
            }
            .padding(.horizontal)
        }
    }
}
