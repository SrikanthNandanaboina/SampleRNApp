//
//  UpswingInitiateCustomerProtocol.swift
//  MyApp
//
//  Created by Srikanth N on 04/12/24.
//

import UpswingSdk
class PartnerInitiateCustomer: UpswingInitiateCustomerProtocol{
  func initiateCustomer(responseCallback: @escaping (UpswingSdk.CustomerInitiationResponse) -> Void) {
    Holder.shared.responseCallback = responseCallback
    UpswingModuleEmitter.shared?.invokeUpswingApiCallFromJS()
  }
}
