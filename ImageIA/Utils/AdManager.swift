//
//  AdManager.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 02/03/25.
//

import GoogleMobileAds

final class AdManager: NSObject {
    static let shared = AdManager()
    private var interstitial: InterstitialAd?
    private var adUnitID: String = "ca-app-pub-3940256099942544/4411468910" // ID de teste do Google

    var onAdDidDismiss: (() -> Void)?

    private override init() {
        super.init()
    }

    func loadInterstitialAd() {
        let request = Request()
        InterstitialAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
        }
    }

    func showInterstitialAd(from viewController: UIViewController) {
        if let interstitial = interstitial {
            interstitial.present(from: viewController)
        } else {
            loadInterstitialAd()
        }
    }
}

extension AdManager: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        loadInterstitialAd()
        onAdDidDismiss?()
    }

    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad failed to present full screen content with error: \(error.localizedDescription)")
    }

    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
}
