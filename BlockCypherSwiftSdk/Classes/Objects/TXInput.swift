//
//  TXInput.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TXInput represents an input consumed within a transaction.
//Typically found within an array in a TX. In most cases, TXInputs are from previous UTXOs,
// with the most prominent exceptions being attempted double-spend and coinbase inputs.
public struct TXInput: Codable {
    
    //The previous transaction hash where this input was an output. Not present for coinbase transactions.
    public var prev_hash: String?
    
    //The index of the output being spent within the previous transaction. Not present for coinbase transactions.
    public var output_index: Int?
    
    //The value of the output being spent within the previous transaction. Not present for coinbase transactions.
    public var output_value: Int?
    
    //The type of script that encumbers the output corresponding to this input.
    public var script_type: String?
    
    //Raw hexadecimal encoding of the script.
    public var script: String?
    
    //An array of public addresses associated with the output of the previous transaction.
    public var addresses: [String] = []
    
    //Legacy 4-byte sequence number, not usually relevant unless dealing with locktime encumbrances.
    public var sequence: Int?
    
    //Optional Number of confirmations of the previous transaction for which this input was an output. Currently, only returned in unconfirmed transactions.
    public var age: Int?
    
    //Optional Name of Wallet or HDWallet from which to derive inputs. Only used when constructing transactions via the Creating Transactions process.
    public var wallet_name: String?
    
    //Optional Token associated with Wallet or HDWallet used to derive inputs. Only used when constructing transactions via the Creating Transactions process.
    public var wallet_token: String?
}
