//
//  ReachabilityViewModel.swift
//  Shop
//
//  Created by Ali on 07/06/2022.
//

import Foundation
import Reachability

class ReachabilityViewModel {
    static func isConnected() -> Bool {
      return  Connectivity.isConnectingToWifiOrCellular()
    }
}
