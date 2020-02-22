//
//  TransactionAPI.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 22/02/2020.
//

import Foundation

public class TransactionAPI: BaseEndpoint {
    
    private let url = "txs"
    
    public override init() {
    }
    
    // MARK: Create Transaction
    public func createNewTransactionEndpoint(tx: TX?, flags: Dictionary<String, String>, completionHandler: @escaping (TXSkeleton?, Int)->Void) {
        fetchPost(endpoint: "\(self.url)/new", queryParams: flags, params: tx, responseType: TXSkeleton.self, completionHandler: completionHandler)
    }
    
    public func sendTransactionEndpoint(txSkeleton: TXSkeleton, completionHandler: @escaping (TXSkeleton?, Int) -> Void) {
        fetchPost(endpoint: "\(self.url)/send", params: txSkeleton, responseType: TXSkeleton.self, completionHandler: completionHandler)
    }
    
    // MARK: Push Raw Transaction
    public func pushRawTransactionEndpoint(txHex: String, completionHandler: @escaping (TX?, Int) -> Void) {
        fetchPost(endpoint: "\(self.url)/push", responseType: TX.self, completionHandler: completionHandler)
    }
    
    public static let shared: TransactionAPI = TransactionAPI()
}
