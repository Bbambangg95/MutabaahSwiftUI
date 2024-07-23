//
//  AlertView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 22/08/23.
//

import SwiftUI

struct AlertView: View {
    let title: String
    let message: String
    let dismissButtonTitle: String
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button(dismissButtonTitle, action: {})
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}
