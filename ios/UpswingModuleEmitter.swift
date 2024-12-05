//
//  UpswingModuleEmitter.swift
//  MyApp
//
//  Created by Srikanth N on 04/12/24.
//

import Foundation
import React
import UpswingSdk
import UIKit
import SwiftUI

@objc(UpswingModuleEmitter)
class UpswingModuleEmitter: RCTEventEmitter {
  
  public static var shared: UpswingModuleEmitter?
  private let initiateCustomer = PartnerInitiateCustomer()

  required override init() {
    super.init()
    UpswingModuleEmitter.shared = self
  }
  
  override func supportedEvents() -> [String] {
    return [Constants.UpswingModule.eventUpswingApiCall]
  }
  
  @objc override static func moduleName() -> String {
    return Constants.UpswingModule.moduleName
  }
  
  @objc func invokeUpswingApiCallFromJS() {
    print("invokeUpswingApiCallFromJS bridge invoke")
    self.sendEvent(withName: Constants.UpswingModule.eventUpswingApiCall, body: nil)
  }
  
  @objc func upswingSuccess(_ ici: String, gst: String) -> Void {
    print("upswingSuccess: ICI \(ici) GST \(gst), bridge invoke")
    let response = SuccessCustomerInitiationResponse(internalCustomerId: ici, guestSessionToken: gst)
    Holder.shared.responseCallback(response)
  }
  
  
  @objc func upswingFailure() -> Void {
    print("upswingFailureResponse bridge invoke")
    Holder.shared.responseCallback(FailureCustomerInitiationResponse())
  }
  
  @objc func launchUpswing() {
    print("launchUpswing bridge invoke")
    let fdHomePageDeepLink = "upswing-access-partner-vstd://?route=launch/fd"
    let upswingView = self.getUpswingView().buildWithDeepLink(deepLink: URL(string: fdHomePageDeepLink)!)
    presentUpswingView(upswingView)
  }
  
 
  @objc func launchUpswingViaDeeplink(_ deeplink:String) {
    print("launchUpswingViaDeeplink bridge invoke")
    let upswingView = self.getUpswingView().buildWithDeepLink(deepLink: URL(string: deeplink)!)
    presentUpswingView(upswingView)
  }
  
  @objc func logoutUpswing(){
    print("logoutUpswing bridge invoke")
    upswingSdkLogout()
  }
  
  private func presentUpswingView(_ upswingView: some View) {
    DispatchQueue.main.async {
      let hostingController = UIHostingController(rootView: upswingView)
      hostingController.preferredContentSize = UIScreen.main.bounds.size
      hostingController.modalPresentationStyle = .fullScreen
      self.getTopMostViewController()?.present(hostingController, animated: true, completion: nil)
    }
  }
  
  private func getUpswingView() -> some UpswingViewBuilder {
    return UpswingViewBuilder()
      .setInitiateCustomer(initiateCustomer)
      .setPartnerCode("ACME") //Partner code provided by Upswing team
      .setUIMode(UpswingTheme.LIGHT)
  }
  
  
  private func getTopMostViewController() -> UIViewController? {
    var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
    while let presentedViewController = topMostViewController?.presentedViewController {
      topMostViewController = presentedViewController
    }
    return topMostViewController
  }
  
  override class func requiresMainQueueSetup() -> Bool {
    return true
  }
}


struct Constants {
    struct UpswingModule {
        static let eventUpswingApiCall = "upswingApiCall"
        static let moduleName = "UpswingModuleEmitter"
    }
}
