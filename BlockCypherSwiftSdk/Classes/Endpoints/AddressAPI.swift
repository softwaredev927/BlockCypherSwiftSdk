//
//  AddressAPI.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 21/02/2020.
//

import Foundation

public class AddressAPI: BaseEndpoint {
    
    private let endPoint = "btc/test3/addrs"
    
    public override init() {
        
    }
    
    public func generateAddress(completionHandler: @escaping (AddressKeyChain?, Bool)->Void) {
        print (self.endPoint)
        fetchUrl(endpoint: self.endPoint, param: nil, responseType: AddressKeyChain.self) { (addrKeyChain, succ) in
            if (succ) {
                completionHandler(addrKeyChain, true)
            } else {
                completionHandler(nil, false)
            }
        }
    }
    
    public static let shared: AddressAPI = AddressAPI()
}
