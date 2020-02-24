//
//  Address.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 22/02/2020.
//

import Foundation

//An Address represents a public address on a blockchain, and contains information about the state of balances and transactions related to this address.
//Typically returned from the Address Balance, Address, and Address Full Endpoint.
public struct Address: Codable {
    
    //Optional The requested address. Not returned if querying a wallet/HD wallet.
    public var address: String?
    
    //Optional The requested wallet object. Only returned if querying by wallet name instead of public address.
    public var wallet: Wallet?
    
    //Optional The requested HD wallet object. Only returned if querying by HD wallet name instead of public address.
    public var hd_wallet: HDWallet?
    
    //Total amount of confirmed satoshis received by this address.
    public var total_received: Int64 = 0
    
    //Total amount of confirmed satoshis sent by this address.
    public var total_sent: Int64 = 0
    
    //Balance of confirmed satoshis on this address.
    //This is the difference between outputs and inputs on this address,
    // but only for transactions that have been included into a block (i.e., for transactions whose confirmations > 0).
    public var balance: Int64 = 0
    
    //Balance of unconfirmed satoshis on this address.
    //Can be negative (if unconfirmed transactions are just spending outputs). Only unconfirmed transactions (haven't made it into a block) are included.
    public var unconfirmed_balance: Int = 0
    
    //Total balance of satoshis, including confirmed and unconfirmed transactions, for this address.
    public var final_balance: Int = 0
    
    //Number of confirmed transactions on this address. Only transactions that have made it into a block (confirmations > 0) are counted.
    public var n_tx: Int = 0
    
    //Number of unconfirmed transactions for this address. Only unconfirmed transactions (confirmations == 0) are counted.
    public var unconfirmed_n_tx: Int = 0
    
    //Final number of transactions, including confirmed and unconfirmed transactions, for this address.
    public var final_n_tx: Int = 0
    
    //Optional To retrieve base URL transactions. To get the full URL, concatenate this URL with a transaction's hash.
    public var tx_url: String?
    
    //Optional Array of full transaction details associated with this address. Usually only returned from the Address Full Endpoint.
    public var txs: [TX]?
    
    //Optional Array of transaction inputs and outputs for this address. Usually only returned from the standard Address Endpoint.
    public var txrefs: [TXRef]?
    
    //Optional All unconfirmed transaction inputs and outputs for this address. Usually only returned from the standard Address Endpoint.
    public var unconfirmed_txrefs: [TXRef]?
    
    //Optional If true, then the Address object contains more transactions than shown. Useful for determining whether to poll the API for more transaction information.
    public var hasMore: Bool?
}
