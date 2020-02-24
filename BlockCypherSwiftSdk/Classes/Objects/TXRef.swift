//
//  TXRef.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TXRef object represents summarized data about a transaction input or output. Typically found in an array within an Address object, which is usually returned from the standard Address Endpoint.
public struct TXRef: Codable {
    
    //Optional The address associated with this transaction input/output. Only returned when querying an address endpoint via a wallet/HD wallet name.
    public var address: String?
    
    //Height of the block that contains this transaction input/output. If it's unconfirmed, this will equal -1.
    public var block_height: Int?
    
    //The hash of the transaction containing this input/output. While reasonably unique, using hashes as identifiers may be unsafe.
    public var tx_hash: String?
    
    //Index of this input in the enclosing transaction. It's a negative number for an output.
    public var tx_input_n: Int?
    
    //Index of this output in the enclosing transaction. It's a negative number for an input.
    public var tx_output_n: Int?
    
    //The value transfered by this input/output in satoshis exchanged in the enclosing transaction.
    public var value: Int?
    
    //The likelihood that the enclosing transaction will make it to the next block;
    // reflects the preference level miners have to include the enclosing transaction. Can be high, medium or low.
    public var preference: String?
    
    //true if this is an output and was spent. If it's an input, or an unspent output, it will be false.
    public var spent: Bool?
    
    //true if this is an attempted double spend; false otherwise.
    public var double_spend: Bool?
    
    //Number of subsequent blocks, including the block the transaction is in. Unconfirmed transactions have 0 confirmations.
    public var confirmations: Int?
    
    //Optional Raw, hex-encoded script of this input/output.
    public var script: String?
    
    //Optional The past balance of the parent address the moment this transaction was confirmed. Not present for unconfirmed transactions.
    public var ref_balance: Int?
    
    //Optional The percentage chance this transaction will not be double-spent against, if unconfirmed. For more information, check the section on Confidence Factor.
    public var confidence: Float?
    
    //Optional Time at which transaction was included in a block; only present for confirmed transactions.
    public var confirmed: String?
    
    //Optional The transaction hash that spent this output. Only returned for outputs that have been spent. The spending transaction may be unconfirmed.
    public var spent_by: String?
    
    //Optional Time this transaction was received by BlockCypher's servers; only present for unconfirmed transactions.
    public var received: String?
    
    //Optional Number of peers that have sent this transaction to BlockCypher; only present for unconfirmed transactions.
    public var receive_count: Int?
    
    //Optional If this transaction is a double-spend (i.e. double_spend == true) then this is the hash of the transaction it's double-spending.
    public var double_of: String?
}


//A NullData Object is used exclusively by our Data Endpoint to embed small pieces of data on the blockchain. If your data is over 40 bytes, it cannot be embedded into the blockchain and will return an error
class NullData {
    
    public var data: String = "" //The string representing the data to embed, can be either hex-encoded or plaintext.
    public var token: String = "" //Optional Your BlockCypher API token, can either be included here or as a URL Parameter in your request.
    public var encoding: String = "" //Optional The encoding of your data, can be either string (for plaintext) or hex (for hex-encoded). If not set, defaults to hex.
    public var hash: String = "" //Optional The hash of the transaction containing your data; only part of return object.
}


//A MicroTX represents a streamlined---and typically much lower value---microtransaction, one which BlockCypher can sign for you if you send your private key. MicroTXs can also be signed on the client-side without ever sending your private key. You'll find these objects used in the Microtransaction API.
//Only one of these three fields is required for the microtransaction endpoint: from_pubkey, from_private, from_wif . If you send more than one, the API will return an error.
class MicroTX {
    
    public var from_pubkey: String = "" //Hex-encoded public key from which you're sending coins.
    public var from_private: String = "" //Hex-encoded private key from which you're sending coins.
    public var from_wif: String = "" //WIF-encoded private key from which you're sending coins.
    public var to_address: String = "" //The target address to which you're sending coins.
    public var value_satoshis: Int = 0 //Value you're sending/you've sent in satoshis.
    public var token: String = "" //Your BlockCypher API token
    public var change_address: String = "" //Optional Address BlockCypher will use to send back your change. If not set, defaults to the address from which the coins were originally sent. While not required, we recommend that you set a change address.
    public var wait_guarantee: Bool = false //Optional If not set, defaults to true, which means the API will wait for BlockCypher to guarantee the transaction, using our Confidence Factor. The guarantee usually takes around 8 seconds. If manually set to false, the Microtransaction endpoint will return as soon as the transaction is broadcast.
    public var tosign: [String] = [] //Optional Hex-encoded data for you to sign after initiating the microtransaction. Sent in reply to a microtransaction generated using from_pubkey/a public key.
    public var signatures: [String] = []//Optional Hex-encoded signatures for you to send back after having received (and signed) tosign.
    public var inputs: [TXInput] = [] //Optional Partial list of inputs that will be used with this transaction. Inputs themsleves are heavily pared down, see cURL sample. Only returned when using from_pubkey.
    public var outputs: [TXOutput] = [] //Optional Partial list of outputs that will be used with this transaction. Outputs themselves are heavily pared down, see cURL sample. Only returned when using from_pubkey.
    public var fees: Int = 0 //Optional BlockCypher's optimally calculated fees for this MicroTX to guarantee swift 99% confirmation, only returned when using from_pubkey. BlockCypher pays these fees for the first 8,000 microtransactions, but like regular transactions, it is deducted from the source address thereafter.
    public var hash: String = "" //Optional The hash of the finalized transaction, once sent.
}






//An OAPIssue represents a request for either issuance or transfer of new assets, as detailed in the Asset API.
class OAPIssue {
    public var from_private: String = "" //The private key being used to issue or transfer assets.
    public var to_address: String = "" //The target OAP address assets for issue or transfer.
    public var amount: Int = 0 //The amount of assets being issued or transfered.
    public var metadata: String = "" //Optional Hex-encoded metadata that can optionally be encoded into the issue or transfer transaction.
}

//An OAPTX represents an Open Assets Protocol transaction, generated when issuing or transfering assets.
class OAPTX {
    public var ver: Int = 0 //Version of Open Assets Protocol transaction. Typically 1.
    public var assetid: String = "" //Unique indentifier associated with this asset; can be used to query other transactions associated with this asset.
    public var hash: String = "" //This transaction's unique hash; same as the underlying transaction on the asset's parent blockchain.
    public var confirmed: String = "" //Optional Time this transaction was confirmed; only returned for confirmed transactions.
    public var received: String = "" //Time this transaction was received.
    public var oap_meta: String = "" //Optional Associated hex-encoded metadata with this transaction, if it exists.
    public var double_spend: Bool = false //true if this is an attempted double spend; false otherwise.
    public var inputs: [TXInput] = [] //Array of input data, which can be seen explicitly in the cURL example. Very similar to array of TXInputs, but with values related to assets instead of satoshis.
    public var outputs: [TXOutput] = [] //Array of output data, which can be seen explicitly in the cURL example. Very similar to array of TXOutputs, but with values related to assets instead of satoshis.
}

