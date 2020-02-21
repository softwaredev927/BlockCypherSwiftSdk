//
//  TXRef.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TXRef object represents summarized data about a transaction input or output. Typically found in an array within an Address object, which is usually returned from the standard Address Endpoint.
class TXRef {
    var address: String = "" //Optional The address associated with this transaction input/output. Only returned when querying an address endpoint via a wallet/HD wallet name.
    var block_height: Int = 0 //Height of the block that contains this transaction input/output. If it's unconfirmed, this will equal -1.
    var tx_hash: String = "" //The hash of the transaction containing this input/output. While reasonably unique, using hashes as identifiers may be unsafe.
    var tx_input_n: Int = 0 //Index of this input in the enclosing transaction. It's a negative number for an output.
    var tx_output_n: Int = 0 //Index of this output in the enclosing transaction. It's a negative number for an input.
    var value: Int = 0 //The value transfered by this input/output in satoshis exchanged in the enclosing transaction.
    var preference: String = "" //The likelihood that the enclosing transaction will make it to the next block; reflects the preference level miners have to include the enclosing transaction. Can be high, medium or low.
    var spent: Bool = false //true if this is an output and was spent. If it's an input, or an unspent output, it will be false.
    var double_spend: Bool = false //true if this is an attempted double spend; false otherwise.
    var confirmations: Int = 0 //Number of subsequent blocks, including the block the transaction is in. Unconfirmed transactions have 0 confirmations.
    var script: String = "" //Optional Raw, hex-encoded script of this input/output.
    var ref_balance: Int = 0 //Optional The past balance of the parent address the moment this transaction was confirmed. Not present for unconfirmed transactions.
    var confidence: Float = 0 //Optional The percentage chance this transaction will not be double-spent against, if unconfirmed. For more information, check the section on Confidence Factor.
    var confirmed: String = "" //Optional Time at which transaction was included in a block; only present for confirmed transactions.
    var spent_by: String = "" //Optional The transaction hash that spent this output. Only returned for outputs that have been spent. The spending transaction may be unconfirmed.
    var received: String = "" //Optional Time this transaction was received by BlockCypher's servers; only present for unconfirmed transactions.
    var receive_count: Int = 0 //Optional Number of peers that have sent this transaction to BlockCypher; only present for unconfirmed transactions.
    var double_of: String = "" //Optional If this transaction is a double-spend (i.e. double_spend == true) then this is the hash of the transaction it's double-spending.
}

class InternalError {
    var error: String = ""
}

//A TXSkeleton is a convenience/wrapper Object that's used primarily when Creating Transactions through the New and Send endpoints.
class TXSkeleton {
    
    var tx: TX = TX() //A temporary TX, usually returned fully filled but missing input scripts.
    var tosign: [String] = [] //of hex-encoded data for you to sign, one for each input.
    var signatures: [String] = [] //of signatures corresponding to all the data in tosign, typically provided by you.
    var pubkeys: [String] = [] //of public keys corresponding to each signature. In general, these are provided by you, and correspond to the signatures you provide.
    var tosign_tx: [String] = [] //Optional Array of hex-encoded, work-in-progress transactions; optionally returned to validate the tosign data locally.
    var errors: [InternalError] = [] //Optional Array of errors in the form "error":"description-of-error". This is only returned if there was an error in any stage of transaction generation, and is usually accompanied by a HTTP 400 code.
}


//A NullData Object is used exclusively by our Data Endpoint to embed small pieces of data on the blockchain. If your data is over 40 bytes, it cannot be embedded into the blockchain and will return an error
class NullData {
    
    var data: String = "" //The string representing the data to embed, can be either hex-encoded or plaintext.
    var token: String = "" //Optional Your BlockCypher API token, can either be included here or as a URL Parameter in your request.
    var encoding: String = "" //Optional The encoding of your data, can be either string (for plaintext) or hex (for hex-encoded). If not set, defaults to hex.
    var hash: String = "" //Optional The hash of the transaction containing your data; only part of return object.
}


//A MicroTX represents a streamlined---and typically much lower value---microtransaction, one which BlockCypher can sign for you if you send your private key. MicroTXs can also be signed on the client-side without ever sending your private key. You'll find these objects used in the Microtransaction API.
//Only one of these three fields is required for the microtransaction endpoint: from_pubkey, from_private, from_wif . If you send more than one, the API will return an error.
class MicroTX {
    
    var from_pubkey: String = "" //Hex-encoded public key from which you're sending coins.
    var from_private: String = "" //Hex-encoded private key from which you're sending coins.
    var from_wif: String = "" //WIF-encoded private key from which you're sending coins.
    var to_address: String = "" //The target address to which you're sending coins.
    var value_satoshis: Int = 0 //Value you're sending/you've sent in satoshis.
    var token: String = "" //Your BlockCypher API token
    var change_address: String = "" //Optional Address BlockCypher will use to send back your change. If not set, defaults to the address from which the coins were originally sent. While not required, we recommend that you set a change address.
    var wait_guarantee: Bool = false //Optional If not set, defaults to true, which means the API will wait for BlockCypher to guarantee the transaction, using our Confidence Factor. The guarantee usually takes around 8 seconds. If manually set to false, the Microtransaction endpoint will return as soon as the transaction is broadcast.
    var tosign: [String] = [] //Optional Hex-encoded data for you to sign after initiating the microtransaction. Sent in reply to a microtransaction generated using from_pubkey/a public key.
    var signatures: [String] = []//Optional Hex-encoded signatures for you to send back after having received (and signed) tosign.
    var inputs: [TXInput] = [] //Optional Partial list of inputs that will be used with this transaction. Inputs themsleves are heavily pared down, see cURL sample. Only returned when using from_pubkey.
    var outputs: [TXOutput] = [] //Optional Partial list of outputs that will be used with this transaction. Outputs themselves are heavily pared down, see cURL sample. Only returned when using from_pubkey.
    var fees: Int = 0 //Optional BlockCypher's optimally calculated fees for this MicroTX to guarantee swift 99% confirmation, only returned when using from_pubkey. BlockCypher pays these fees for the first 8,000 microtransactions, but like regular transactions, it is deducted from the source address thereafter.
    var hash: String = "" //Optional The hash of the finalized transaction, once sent.
}

//An Address represents a public address on a blockchain, and contains information about the state of balances and transactions related to this address. Typically returned from the Address Balance, Address, and Address Full Endpoint.
class Address {
    
    var address: String = "" //Optional The requested address. Not returned if querying a wallet/HD wallet.
    var wallet: Wallet = Wallet() //Optional The requested wallet object. Only returned if querying by wallet name instead of public address.
    var hd_wallet: HDWallet = HDWallet() //Optional The requested HD wallet object. Only returned if querying by HD wallet name instead of public address.
    var total_received: Int = 0 //Total amount of confirmed satoshis received by this address.
    var total_sent: Int = 0 //Total amount of confirmed satoshis sent by this address.
    var balance: Int = 0 //Balance of confirmed satoshis on this address. This is the difference between outputs and inputs on this address, but only for transactions that have been included into a block (i.e., for transactions whose confirmations > 0).
    var unconfirmed_balance: Int = 0 //Balance of unconfirmed satoshis on this address. Can be negative (if unconfirmed transactions are just spending outputs). Only unconfirmed transactions (haven't made it into a block) are included.
    var final_balance: Int = 0 //Total balance of satoshis, including confirmed and unconfirmed transactions, for this address.
    var n_tx: Int = 0 //Number of confirmed transactions on this address. Only transactions that have made it into a block (confirmations > 0) are counted.
    var unconfirmed_n_tx: Int = 0 //Number of unconfirmed transactions for this address. Only unconfirmed transactions (confirmations == 0) are counted.
    var final_n_tx: Int = 0 //Final number of transactions, including confirmed and unconfirmed transactions, for this address.
    var tx_url: String = "" //Optional To retrieve base URL transactions. To get the full URL, concatenate this URL with a transaction's hash.
    var txs: [TX] = [] //Optional Array of full transaction details associated with this address. Usually only returned from the Address Full Endpoint.
    var txrefs: [TXRef] = [] //Optional Array of transaction inputs and outputs for this address. Usually only returned from the standard Address Endpoint.
    var unconfirmed_txrefs: [TXRef] = [] //Optional All unconfirmed transaction inputs and outputs for this address. Usually only returned from the standard Address Endpoint.
    var hasMore: Bool = false //Optional If true, then the Address object contains more transactions than shown. Useful for determining whether to poll the API for more transaction information.
}


    // wallet
class Wallet {
    var token: String = "" //User token associated with this wallet.
    var name: String = "" //Name of the wallet.
    var addresses: [String] = [] //List of addresses associated with this wallet.
}

//An HDWallet contains addresses derived from a single seed. Like normal wallets, it can be used interchangeably with all the Address API endpoints, and in many places that require addresses, like when Creating Transactions.
class HDWallet {
    
    var token: String = "" //User token associated with this HD wallet.
    var name: String = "" //Name of the HD wallet.
    var chains: [HDChain] = [] //List of HD chains associated with this wallet, each containing HDAddresses. A single chain is returned if the wallet has no subchains.
    var hd: Bool = false //true for HD wallets, not present for normal wallets.
    var extended_public_key: String = "" //The extended public key all addresses in the HD wallet are derived from. It's encoded in BIP32 format
    var subchain_indexes: [Int] = [] //optional returned for HD wallets created with subchains.
}

//An array of HDChains are included in every HDWallet and returned from the Get Wallet, Get Wallet Addresses and Derive Address in Wallet endpoints.
class HDChain {
    var chain_addresses: [HDAddress] = [] //Array of HDAddresses associated with this subchain.
    var index: Int = 0 //optional Index of the subchain, returned if the wallet has subchains.
}

//An HD Address object contains an address and its BIP32 HD path (location of the address in the HD tree). It also contains the hex-encoded public key when returned from the Derive Address in Wallet endpoint.
class HDAddress {
    var address: String = "" //Standard address representation.
    var path: String = "" //The BIP32 path of the HD address.
    //original name: public
    var publicAddress: String = "" //optional Contains the hex-encoded public key if returned by Derive Address in Wallet endpoint.
}

//An OAPIssue represents a request for either issuance or transfer of new assets, as detailed in the Asset API.
class OAPIssue {
    var from_private: String = "" //The private key being used to issue or transfer assets.
    var to_address: String = "" //The target OAP address assets for issue or transfer.
    var amount: Int = 0 //The amount of assets being issued or transfered.
    var metadata: String = "" //Optional Hex-encoded metadata that can optionally be encoded into the issue or transfer transaction.
}

//An OAPTX represents an Open Assets Protocol transaction, generated when issuing or transfering assets.
class OAPTX {
    var ver: Int = 0 //Version of Open Assets Protocol transaction. Typically 1.
    var assetid: String = "" //Unique indentifier associated with this asset; can be used to query other transactions associated with this asset.
    var hash: String = "" //This transaction's unique hash; same as the underlying transaction on the asset's parent blockchain.
    var confirmed: String = "" //Optional Time this transaction was confirmed; only returned for confirmed transactions.
    var received: String = "" //Time this transaction was received.
    var oap_meta: String = "" //Optional Associated hex-encoded metadata with this transaction, if it exists.
    var double_spend: Bool = false //true if this is an attempted double spend; false otherwise.
    var inputs: [TXInput] = [] //Array of input data, which can be seen explicitly in the cURL example. Very similar to array of TXInputs, but with values related to assets instead of satoshis.
    var outputs: [TXOutput] = [] //Array of output data, which can be seen explicitly in the cURL example. Very similar to array of TXOutputs, but with values related to assets instead of satoshis.
}

//An Event represents a WebHooks or WebSockets-based notification request, as detailed in the Events & Hooks section of the documentation.
class Event {
    var id: String = "" //Identifier of the event; generated when a new request is created.
    var event: String = "" //Type of event; can be unconfirmed-tx, new-block, confirmed-tx, tx-confirmation, double-spend-tx, tx-confidence.
    var hash: String = "" //optional Only objects with a matching hash will be sent. The hash can either be for a block or a transaction.
    var wallet_name: String = "" //optional Only transactions associated with the given wallet will be sent; can use a regular or HD wallet name. If used, requires a user token.
    var token: String = "" //optional Required if wallet_name is used, though generally we advise users to include it (as they can reach API throttling thresholds rapidly).
    var address: String = "" //optional Only transactions associated with the given address will be sent. A wallet name can also be used instead of an address, which will then match on any address in the wallet.
    var confirmations: Int = 0 //optional Used in concert with the tx-confirmation event type to set the number of confirmations desired for which to receive an update. You'll receive an updated TX for every confirmation up to this amount. The maximum allowed is 10; if not set, it will default to 6.
    var confidence: Float = 0 //optional Used in concert with the tx-confidence event type to set the minimum confidence for which you'll receive a notification. You'll receive a TX once this threshold is met. Will accept any float between 0 and 1, exclusive; if not set, defaults to 0.99.
    var script: String = "" //optional Only transactions with an output script of the provided type will be sent. The recognized types of scripts are: pay-to-pubkey-hash, pay-to-multi-pubkey-hash, pay-to-pubkey, pay-to-script-hash, null-data (sometimes called OP_RETURN), empty or unknown.
    var url: String = "" //optional Callback URL for this Event's WebHook; not applicable for WebSockets usage.
    var callback_errors: Int = 0 //Number of errors when attempting to POST to callback URL; not applicable for WebSockets usage.
}

//A PaymentForward object represents a request set up through the Payment Forwarding service.
class PaymentForward {
    var id: String = "" //Identifier of the payment forwarding request; generated when a new request is created.
    var token: String = "" //The mandatory user token.
    var destination: String = "" //The required destination address for payment forwarding.
    var input_address: String = "" //The address which will automatically forward to destination; generated when a new request is created.
    var process_fees_address: String = "" //Optional Address to forward processing fees, if specified. Allows you to receive a fee for your own services.
    var process_fees_satoshis: Int = 0 //Optional Fixed processing fee amount to be sent to the fee address. A fixed satoshi amount or a percentage is required if a process_fees_address has been specified.
    var process_fees_percent: Float = 0 //Optional Percentage of the transaction to be sent to the fee address. A fixed satoshi amount or a percentage is required if a process_fees_address has been specified.
    var callback_url: String = "" //Optional The URL to call anytime a new payment is forwarded.
    var enable_confirmations: Bool = false //Optional Whether to also call the callback_url with subsequent confirmations of the forwarding transactions. Automatically sets up a WebHook.
    var mining_fees_satoshis: Int = 0 //Optional Mining fee amount to include in the forwarding transaction, in satoshis. If not set, defaults to 10,000.
    var txs: [String] = [] //Optional History of forwarding transaction hashes for this payment forward; not present if this request has yet to forward any transactions.
}


//A PaymentForwardCallback object represents the payload delivered to the optional callback_url in a PaymentForward request.
class PaymentForwardCallback {
    
    var value: Int = 0 //Amount sent to the destination address, in satoshis.
    var input_address: String = "" //The intermediate address to which the payment was originally sent.
    var destination: String = "" //The final destination address to which the payment will eventually be sent.
    var input_transaction_hash: String = "" //The transaction hash representing the initial payment to the input_address.
    var transaction_hash: String = "" //The transaction hash of the generated transaction that forwards the payment from the input_address to the destination.
}

//A Job represents an analytics query set up through the Analytics API.
class Job {
    
    var token: String = "" //The token that created this job.
    var analytics_engine: String = "" //The engine used for the job query.
    var created_at: String = "" //The time this job was created.
    var completed_at: String = "" //Optional When this job was completed; only present on complete jobs.
    var finished: Bool = false //true if this job is finished processing, false otherwise.
    var started: Bool = false //true if this job has begun processing, false otherwise.
    var ticket: String = "" //Unique identifier for this job, used to get job status and results.
    var result_path: String = "" //Optional URL to query job results; only present on complete jobs.
    var args: JobArgs = JobArgs() //Query arguments for this job.
}


//A JobArgs represents the query parameters of a particular analytics job, used when Creating an Analytics Job and returned within a Job. Note that the required and optional arguments can change depending on the engine you're using; for more specifics check the Analytics Engine and Parameters section.
class JobArgs {
    
    var address: String = "" //Address hash this job is querying.
    var value_threshold: Int = 0 //Minimal/threshold value (in satoshis) to query.
    var limit: Int = 0 //Limit of results to return.
    var start: String = "" //Beginning of time range to query.
    var end: String = "" //End of time range to query.
    var degree: Int = 0 //Degree of connectiveness to query.
    var source: String = "" //IP address and port, of the form "0.0.0.0:80". Ideally an IP and port combination found from another API lookup (for example, relayed_by from the Transaction Hash Endpoint)
}

//  A JobResults represents the result of a particular analytics job, returned from Get Analytics Job Results. Note that the results field will depend largely on the engine used.
class JobResult {
    var page: Int = 0 //Current page of results.
    var more: Bool = false //true if there are more results in a separate page; false otherwise.
    var next_page: String = "" //Optional URL to get the next page of results; only present if there are more results to show.
    var results: [Job] = [] //Results of analytics job; structure of results are dependent on engine-type of query, but are generally either strings of address hashes or JSON objects.
}
