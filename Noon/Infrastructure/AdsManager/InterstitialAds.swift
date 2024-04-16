//
//  InterstitialAds.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/04/24.
//

import Foundation

import SwiftUI
import GoogleMobileAds
import UIKit

final class InterstitialAd: NSObject, GADFullScreenContentDelegate {
    var interstitial: GADInterstitialAd?
    var adID = AdsId.interstitial.rawValue
    var onAdDismissed: (() -> Void)?
    
    override init() {
        super.init()
        self.loadInterstitial()
    }
    
    func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: adID, request: request, completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
    }
    
    func showAd() {
        if let fullScreenAd = self.interstitial {
            guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            guard let firstWindow = firstScene.windows.first else {
                return
            }
            let root = firstWindow.rootViewController
            fullScreenAd.present(fromRootViewController: root!)
        } else {
            print("Not Ready")
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.loadInterstitial()
        onAdDismissed?()
    }
    
    // Method to set the callback closure
    func setOnAdDismissed(_ callback: @escaping () -> Void) {
        onAdDismissed = callback
    }
}
