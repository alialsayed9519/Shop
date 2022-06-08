//
//  Reachability.swift
//  Shop
//
//  Created by Ali on 07/06/2022.
//

import Foundation
import Alamofire

class Connectivity {

   static func isConnectingToWifiOrCellular() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
