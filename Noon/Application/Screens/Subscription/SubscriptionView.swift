//
//  SubscriptionView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/04/24.
//

import SwiftUI

struct SubscriptionView: View {
    @StateObject var subscriptionManager = SubscriptionManager()
    
    var body: some View {
        VStack {
            ForEach(subscriptionManager.products, id: \.self) { product in
                Button("Purchase \(product.localizedTitle)") {
                    subscriptionManager.purchase(product: product)
                }
            }
        }
        .onAppear {
            subscriptionManager.fetchProducts()
        }
    }
}
