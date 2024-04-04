//
//  SubscriptionManager.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 07/04/24.
//

import Foundation
import SwiftUI
import StoreKit

class SubscriptionManager: NSObject, ObservableObject, SKPaymentTransactionObserver {
    @Published var products: [SKProduct] = []
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    func fetchProducts() {
        let productIdentifiers: Set<String> = ["premiumplan"]
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
        print(products)
    }
    
    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Handle successful purchase
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                // Handle failed purchase
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Handle restored purchase
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
}

extension SubscriptionManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
}
