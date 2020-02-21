//
//  Blockchain.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A Blockchain represents the current state of a particular blockchain from the Coin/Chain resources that BlockCypher supports.
//Typically returned from the Chain API endpoint.
class Blockchain {
    
    //The name of the blockchain represented, in the form of $COIN.$CHAIN.
    var name: String = ""
    
    //The current height of the blockchain; i.e., the number of blocks in the blockchain.
    var height: Int = 0

    //The hash of the latest confirmed block in the blockchain; in Bitcoin, the hashing function is SHA256(SHA256(block)).
    var hash: String = ""
    
    //The time of the latest update to the blockchain; typically when the latest block was added.
    var time: String = ""

    //The BlockCypher URL to query for more information on the latest confirmed block; returns a Block.
    var latest_url: String = ""
    
    //The hash of the second-to-latest confirmed block in the blockchain.
    var revious_hash: String = ""
    
    //The BlockCypher URL to query for more information on the second-to-latest confirmed block; returns a Block.
    var previous_url: String = ""

    //N/A, will be deprecated soon.
    var peer_count: Int = 0

    //A rolling average of the fee (in satoshis) paid per kilobyte for transactions to be confirmed within 1 to 2 blocks.
    var high_fee_per_kb: Int = 0

    //A rolling average of the fee (in satoshis) paid per kilobyte for transactions to be confirmed within 3 to 6 blocks.
    var medium_fee_per_kb: Int = 0
    
    //A rolling average of the fee (in satoshis) paid per kilobyte for transactions to be confirmed in 7 or more blocks.
    var low_fee_per_kb: Int = 0

    //Number of unconfirmed transactions in memory pool (likely to be included in next block).
    var unconfirmed_count: Int = 0

    //Optional The current height of the latest fork to the blockchain; when no competing blockchain fork present, not returned with endpoints that return Blockchains.
    var last_fork_height: Int = 0

    //Optional The hash of the latest confirmed block in the latest fork of the blockchain; when no competing blockchain fork present, not returned with endpoints that return Blockchains.
    var last_fork_hash: String = ""
}
