//
//  Block.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A Block represents the current state of a particular block from a Blockchain.
//Typically returned from the Block Hash and Block Height endpoints.
public struct Block: Codable {
    
    //The hash of the block; in Bitcoin, the hashing function is SHA256(SHA256(block))
    var hash: String = ""
    
    //The height of the block in the blockchain; i.e., there are height earlier blocks in its blockchain.
    var height: Int = 0
    
    //The depth of the block in the blockchain; i.e., there are depth later blocks in its blockchain.
    var depth: Int = 0
    
    //The name of the blockchain represented, in the form of $COIN.$CHAIN
    var chain: String = ""
    
    //The total number of satoshis transacted in this block.
    var total: Int = 0
    
    //The total number of fees---in satoshis---collected by miners in this block.
    var fees: Int = 0
    
    //Optional Raw size of block (including header and all transactions) in bytes.
    //Not returned for bitcoin blocks earlier than height 389104.
    var size: Int?
    
    //Block version.
    var ver: Int = 0
    
    //Recorded time at which block was built. Note: Miners rarely post accurate clock times.
    var time: String = "2014-04-05T07:49:18Z"
    
    //The time BlockCypher's servers receive the block. Our servers' clock is continuously adjusted and accurate.
    var received_time: String = "2014-04-05T07:49:18Z"
    
    //Address of the peer that sent BlockCypher's servers this block.
    var relayed_by: String = ""
    
    //The block-encoded difficulty target.
    var bits: Int = 0
    
    //The number used by a miner to generate this block.
    var nonce: Int = 0
    
    //Number of transactions in this block.
    var n_tx: Int = 0
    
    //The hash of the previous block in the blockchain.
    var prev_block: String = ""
    
    //The BlockCypher URL to query for more information on the previous block.
    var prev_block_url: String = ""
    
    //The base BlockCypher URL to receive transaction details.
    //To get more details about specific transactions, you must concatenate this URL with the desired transaction hash(es).
    var tx_url: String = ""
    
    //The Merkle root of this block.
    var mrkl_root: String = ""
    
    //An array of transaction hashes in this block. By default, only 20 are included.
    var txids: [String] = []
    
    //Optional If there are more transactions that couldn't fit in the txids array,
    // this is the BlockCypher URL to query the next set of transactions (within a Block object).
    var next_txids: String?
}
