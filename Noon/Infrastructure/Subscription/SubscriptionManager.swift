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
    static let shared = SubscriptionManager()
    
    @Published var products: [SKProduct] = []
    @Published var isSubscribed: Bool = false
    
    private var purchasedProductIDs: Set<String> = []
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        loadSubscriptionStatus()
    }
    
    func fetchProducts() {
        let productIdentifiers: Set<String> = [SubscriptionId.productID.rawValue]
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePayment() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    private func loadSubscriptionStatus() {
            if let savedProductIDs = UserDefaults.standard.array(forKey: "PurchasedProductIDs") as? [String] {
                purchasedProductIDs = Set(savedProductIDs)
                updateSubscriptionStatus()
            }
        }
        
    private func saveSubscriptionStatus() {
        UserDefaults.standard.set(Array(purchasedProductIDs), forKey: "PurchasedProductIDs")
        updateSubscriptionStatus()
    }
    
    private func updateSubscriptionStatus() {
        isSubscribed = !purchasedProductIDs.isEmpty
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Handle successful purchase
                handlePurchase(transaction: transaction)
            case .failed:
                // Handle failed purchase
                handleFailed(transaction: transaction)
            case .restored:
                // Handle restored purchase
                handleRestore(transaction: transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func handlePurchase(transaction: SKPaymentTransaction) {
            purchasedProductIDs.insert(transaction.payment.productIdentifier)
            saveSubscriptionStatus()
            SKPaymentQueue.default().finishTransaction(transaction)
        }
        
    private func handleRestore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else {
            return
        }
        purchasedProductIDs.insert(productIdentifier)
        saveSubscriptionStatus()
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleFailed(transaction: SKPaymentTransaction) {
        if let error = transaction.error {
            print("Transaction failed with error: \(error.localizedDescription)")
        }
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

extension SubscriptionManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
}
