//
//  GoogleAds.swift
//  MCU Trivia
//
//  Created by Zach Uptin on 13/7/2022.
//

//import Foundation
//import GoogleMobileAds
//import UIKit
//
//let test = "ca-app-pub-3940256099942544/4411468910"
//let myAd = "ca-app-pub-4765977749695147/5929721516"
//    
//final class Interstitial: NSObject, GADFullScreenContentDelegate {
//    var interstitial:GADInterstitialAd?
//    
//    override init() {
//        super.init()
//        LoadInterstitial()
//    }
//    
//    func LoadInterstitial(){
//        self.interstitial = nil
//        let request = GADRequest()
//        GADInterstitialAd.load(withAdUnitID: test, request: request) { interstialAd, error in  /// change test to myAd for release
//            if error == nil {
//                if let ad = interstialAd {
//                    // we do have ad
//                    self.interstitial = ad
//                    self.interstitial?.fullScreenContentDelegate = self
//                }
//            } else {
//                print("Error == \(error) and localized info == \(error?.localizedDescription)")
//            }
//        }
//    }
//    
//    func showAd(){
//        
//        if self.interstitial != nil {
//            guard let root = UIApplication.shared.windows.first?.rootViewController else {return}
//            self.interstitial?.present(fromRootViewController: root)
//        }
//    }
//    
//    
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        print("ad fail to present as full screen")
//    }
//    
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        LoadInterstitial()
//    }
//
//}
