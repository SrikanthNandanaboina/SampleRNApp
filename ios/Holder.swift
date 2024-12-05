//
//  Holder.swift
//  MyApp
//
//  Created by Srikanth N on 04/12/24.
//

import UpswingSdk

class Holder {
    private init() {
    }
    static let shared = Holder()
    var responseCallback: (CustomerInitiationResponse) -> Void = { _ in }
}
