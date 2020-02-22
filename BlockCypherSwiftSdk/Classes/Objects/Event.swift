//
//  Event.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 22/02/2020.
//

import Foundation


//An Event represents a WebHooks or WebSockets-based notification request, as detailed in the Events & Hooks section of the documentation.
public struct Event: Codable {
    
    //Identifier of the event; generated when a new request is created.
    var id: String = ""
    
    //Type of event; can be unconfirmed-tx, new-block, confirmed-tx, tx-confirmation, double-spend-tx, tx-confidence.
    var event: String = ""
    
    //optional Only objects with a matching hash will be sent. The hash can either be for a block or a transaction.
    var hash: String?
    
    //optional Only transactions associated with the given wallet will be sent; can use a regular or HD wallet name. If used, requires a user token.
    var wallet_name: String?
    
    //optional Required if wallet_name is used, though generally we advise users to include it (as they can reach API throttling thresholds rapidly).
    var token: String?
    
    //optional Only transactions associated with the given address will be sent.
    //A wallet name can also be used instead of an address, which will then match on any address in the wallet.
    var address: String?
    
    //optional Used in concert with the tx-confirmation event type to set the number of confirmations desired for which to receive an update.
    //You'll receive an updated TX for every confirmation up to this amount. The maximum allowed is 10; if not set, it will default to 6.
    var confirmations: Int?
    
    //optional Used in concert with the tx-confidence event type to set the minimum confidence for which you'll receive a notification.
    //You'll receive a TX once this threshold is met. Will accept any float between 0 and 1, exclusive; if not set, defaults to 0.99.
    var confidence: Float?
    
    //optional Only transactions with an output script of the provided type will be sent.
    //The recognized types of scripts are: pay-to-pubkey-hash, pay-to-multi-pubkey-hash, pay-to-pubkey, pay-to-script-hash, null-data
    // (sometimes called OP_RETURN), empty or unknown.
    var script: String?
    
    //optional Callback URL for this Event's WebHook; not applicable for WebSockets usage.
    var url: String?
    
    //Number of errors when attempting to POST to callback URL; not applicable for WebSockets usage.
    var callback_errors: Int = 0
}
