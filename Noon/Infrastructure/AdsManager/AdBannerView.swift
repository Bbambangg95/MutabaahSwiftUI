//
//  AdsBannerView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 08/04/24.
//

import SwiftUI
import GoogleMobileAds

struct AdBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = AdsId.banner.rawValue // Replace with your AdMob ad unit ID
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = scene.windows.first
            bannerView.rootViewController = window?.rootViewController
        }
        
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update code here if needed
    }
}
