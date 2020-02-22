//
//  PaymentForward.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 22/02/2020.
//

import Foundation

//A PaymentForward object represents a request set up through the Payment Forwarding service.
public struct PaymentForward: Codable {
    
    //Identifier of the payment forwarding request; generated when a new request is created.
    var id: String = ""
    
    //The mandatory user token.
    var token: String = ""
    
    //The required destination address for payment forwarding.
    var destination: String = ""
    
    //The address which will automatically forward to destination; generated when a new request is created.
    var input_address: String = ""
    
    //Optional Address to forward processing fees, if specified. Allows you to receive a fee for your own services.
    var process_fees_address: String?
    
    //Optional Fixed processing fee amount to be sent to the fee address. A fixed satoshi amount or a percentage is required if a process_fees_address has been specified.
    var process_fees_satoshis: Int?
    
    //Optional Percentage of the transaction to be sent to the fee address.
    //A fixed satoshi amount or a percentage is required if a process_fees_address has been specified.
    var process_fees_percent: Float?
    
    //Optional The URL to call anytime a new payment is forwarded.
    var callback_url: String?
    
    //Optional Whether to also call the callback_url with subsequent confirmations of the forwarding transactions. Automatically sets up a WebHook.
    var enable_confirmations: Bool?
    
    //Optional Mining fee amount to include in the forwarding transaction, in satoshis. If not set, defaults to 10,000.
    var mining_fees_satoshis: Int?
    
    //Optional History of forwarding transaction hashes for this payment forward; not present if this request has yet to forward any transactions.
    var txs: [String]?
}


//A PaymentForwardCallback object represents the payload delivered to the optional callback_url in a PaymentForward request.
public struct PaymentForwardCallback: Codable {
    
     //Amount sent to the destination address, in satoshis.
    var value: Int = 0
    
    //The intermediate address to which the payment was originally sent.
    var input_address: String = ""
    
    //The final destination address to which the payment will eventually be sent.
    var destination: String = ""
    
    //The transaction hash representing the initial payment to the input_address.
    var input_transaction_hash: String = ""
    
    //The transaction hash of the generated transaction that forwards the payment from the input_address to the destination.
    var transaction_hash: String = ""
}


