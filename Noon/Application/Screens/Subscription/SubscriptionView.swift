//
//  SubscriptionView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/04/24.
//

import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var selectedProduct: SKProduct? = nil
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                Image(systemName: "graduationcap.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Color.blue)
                    .padding(.top, 25)
                Text("Subscription Plan")
                    .font(.title)
                    .padding(.vertical, 5)
                    .fontWeight(.semibold)
                Text("Subscribe now for exclusive feature access. Please review our subscription details before purchasing.")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Label {
                            Text("Remove All Ads")
                                .fontWeight(.semibold)
                                .font(.title3)
                        } icon: {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(Color.blue)
                        }
                        
                        Label {
                            VStack(alignment: .leading) {
                                Text("Full Access to Premium Features")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                Text("Export data to CSV & PDF")
                                Text("Attendance Recap")
                                Text("Memorization Recap")
                            }
                        } icon: {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(Color.blue)
                        }
                    }
                    .padding(.vertical, 5)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("Subscriptions details")
                        .font(.caption)
                    Text("Payment will be charged to your iTunes Account at the confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24 hours before the end of the current period. You will be charged for renewal within 24 hours before the end of the current period. The cost of the renewal will be identified. Subscriptions can be managed by the user, and auto-renewal may be turned off in your Account Settings in iTunes after purchase. Any unused portion of a free trial period, if offered, will be forfeited when you purchase a subscription to that publication, where applicable. The subscription will renew at the same price unless otherwise stated. If the subscription renewal fails, Apple will attempt to recover it for up to 60 days. During this time, you may need to pause access to your service or content. If the subscription is recovered within the Billing Grace Period, there won’t be any interruption to the days of paid service or to your revenue. If the price of a subscription increases, you will be notified, and your consent will be required to continue. You are responsible for any uncollected amounts if Apple cannot charge your payment method for any reason, such as expiration or insufficient funds, and you have not cancelled the subscription. Certain subscriptions may offer a free trial prior to charging your payment method. If you decide to unsubscribe from a subscription before it starts charging your payment method, cancel the subscription at least 24 hours before the free trial ends.")
                    Text("Please review our Terms of Use and Privacy Policy for more details on how we handle your personal information and subscription details.")
                    HStack {
                        Text("Terms of Use")
                            .underline() // Underline the text to indicate it's clickable
                            .foregroundColor(.blue) // Change text color to blue
                            .onTapGesture {
                                if let url = URL(string: "https://mutabaahlandingpages.vercel.app") {
                                    UIApplication.shared.open(url)
                                }
                            }
                        Text("Privacy Policy")
                            .underline() // Underline the text to indicate it's clickable
                            .foregroundColor(.blue) // Change text color to blue
                            .onTapGesture {
                                if let url = URL(string: "https://mutabaahlandingpages.vercel.app") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                }
                .font(.caption2)
                .padding(.top, 10)
            }
            Spacer()
            ForEach(subscriptionManager.products, id: \.self) { product in
                ZStack {
                    RoundedRectangle(cornerRadius: 12.5)
                        .stroke(selectedProduct == product ? .blue : .black, lineWidth: 1.0)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(product.localizedTitle)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text("Get full access for just $\(product.price)")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                            if let subscriptionPeriod = product.subscriptionPeriod {
                                Text("\(subscriptionPeriod.numberOfUnits) \(unitString(from: subscriptionPeriod.unit)) subscription (auto-renewable)")
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .italic()
                            }
                        }
                        Spacer()
                        Image(systemName: selectedProduct == product ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedProduct == product ? .blue : .gray)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 85, alignment: .center)
                .onTapGesture {
                    selectedProduct = product
                }
            }
            Button {
                subscriptionManager.purchase(product: selectedProduct!)
            } label: {
                VStack {
                    Text("Purchase")
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(selectedProduct == nil ? Color.gray : Color.blue)
                )
            }
            .disabled(selectedProduct == nil)
        }
        .padding()
        .onAppear {
            subscriptionManager.fetchProducts()
        }
    }
}
func unitString(from unit: SKProduct.PeriodUnit) -> String {
    switch unit {
    case .day:
        return "day(s)"
    case .week:
        return "week(s)"
    case .month:
        return "month(s)"
    case .year:
        return "year(s)"
    default:
        return "unit(s)"
    }
}
