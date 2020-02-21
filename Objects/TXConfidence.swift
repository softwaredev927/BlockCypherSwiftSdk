//
//  TXConfidence.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TXConfidence represents information about the confidence that an unconfirmed transaction will make it into the next block.
//Typically used as a return object from the Transaction Confidence Endpoint.

class TXConfidence {
    
    //The age of the transaction in milliseconds, based on the earliest time BlockCypher saw it relayed in the network.
    var age_millis: Int = 0
    
    //Number of peers that have sent this transaction to BlockCypher; only positive for unconfirmed transactions. -1 for confirmed transactions.
    var receive_count: Int = 0
    
    //A number from 0 to 1 representing BlockCypher's confidence that the transaction won't be double-spent against.
    var confidence: Float = 0
    
    //The hash of the transaction. While reasonably unique, using hashes as identifiers may be unsafe.
    var txhash: String = ""
    
    //The BlockCypher URL one can use to query more detailed information about this transaction.
    var txurl: String = ""
}
