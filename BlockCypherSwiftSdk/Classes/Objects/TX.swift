//
//  TX.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TX represents the current state of a particular transaction from either a Block within a Blockchain,
// or an unconfirmed transaction that has yet to be included in a Block.
//Typically returned from the Unconfirmed Transactions and Transaction Hash endpoints.
public struct TX: Codable {
    
    public init() {
    }

    //Height of the block that contains this transaction. If this is an unconfirmed transaction, it will equal -1.
    public var block_height: Int?
    
    //The hash of the transaction. While reasonably unique, using hashes as identifiers may be unsafe.
    public var hash: String?
    
    //Array of bitcoin public addresses involved in the transaction.
    public var addresses: [String]?
    
    //The total number of satoshis exchanged in this transaction.
    public var total: Int64?
    
    //The total number of fees---in satoshis---collected by miners in this transaction.
    public var fees: Int64?
    
    //The size of the transaction in bytes.
    public var size: Int?
    
    //The likelihood that this transaction will make it to the next block; reflects the preference level miners have to include this transaction.
    //Can be high, medium or low.
    public var preference: String?
    
    //Address of the peer that sent BlockCypher's servers this transaction.
    public var relayed_by: String?
    
    //Time this transaction was received by BlockCypher's servers.
    public var received: String?
    
    //Version number, typically 1 for Bitcoin transactions.
    public var ver: Int?
    
    //Time when transaction can be valid. Can be interpreted in two ways: if less than 500 million, refers to block height. If more, refers to Unix epoch time.
    public var lock_time: Int?
    
    //true if this is an attempted double spend; false otherwise.
    public var double_spend: Bool?
    
    //Total number of inputs in the transaction.
    public var vin_sz: Int?
    
    //Total number of outputs in the transaction.
    public var vout_sz: Int?
    
    //Number of subsequent blocks, including the block the transaction is in. Unconfirmed transactions have 0 confirmations.
    public var confirmations: Int?
    
    //TXInput Array, limited to 20 by default.
    public var inputs: [TXInput] = []
    
    //TXOutput Array, limited to 20 by default.
    public var outputs: [TXOutput] = []
    
    //Optional Returns true if this transaction has opted in to Replace-By-Fee (RBF), either true or not present. You can read more about Opt-In RBF here.
    public var opt_in_rbf: Bool?
    
    //Optional The percentage chance this transaction will not be double-spent against, if unconfirmed. For more information, check the section on Confidence Factor.
    public var confidence: Float?
    
    //Optional Time at which transaction was included in a block; only present for confirmed transactions.
    public var confirmed: String?
    
    //Optional Number of peers that have sent this transaction to BlockCypher; only present for unconfirmed transactions.
    public var receive_count: Int?
    
    //Optional Address BlockCypher will use to send back your change, if you constructed this transaction.
    //If not set, defaults to the address from which the coins were originally sent.
    public var change_address: String?
    
    //Optional Hash of the block that contains this transaction; only present for confirmed transactions.
    public var block_hash: String?
    
    //Optional Canonical, zero-indexed location of this transaction in a block; only present for confirmed transactions.
    public var block_index: Int?
    
    //Optional If this transaction is a double-spend (i.e. double_spend == true) then this is the hash of the transaction it's double-spending.
    public var double_of: String?

    //Optional Returned if this transaction contains an OP_RETURN associated with a known data protocol. Data protocols currently detected: blockchainid ; openassets ; factom ; colu ; coinspark ; omni
    public var data_protocol: String?

    //Optional Hex-encoded bytes of the transaction, as sent over the network.
    public var hex: String?

    //Optional If there are more transaction inptus that couldn't fit into the TXInput array,
    // this is the BlockCypher URL to query the next set of TXInputs (within a TX object).
    public var next_inputs: String?

    //Optional If there are more transaction outputs that couldn't fit into the TXOutput array,
    // this is the BlockCypher URL to query the next set of TXOutputs(within a TX object).
    public var next_outputs: String?
}
