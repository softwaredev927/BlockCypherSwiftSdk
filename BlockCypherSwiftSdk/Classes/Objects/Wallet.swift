//
//  Wallet.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 22/02/2020.
//

import Foundation


// wallet
public struct Wallet: Codable {
    
    var token: String = "" //User token associated with this wallet.
    var name: String = "" //Name of the wallet.
    var addresses: [String] = [] //List of addresses associated with this wallet.
}

//An HDWallet contains addresses derived from a single seed.
//Like normal wallets, it can be used interchangeably with all the Address API endpoints,
// and in many places that require addresses, like when Creating Transactions.
public struct HDWallet: Codable {
    
    var token: String = "" //User token associated with this HD wallet.
    var name: String = "" //Name of the HD wallet.
    var chains: [HDChain] = [] //List of HD chains associated with this wallet, each containing HDAddresses. A single chain is returned if the wallet has no subchains.
    var hd: Bool = false //true for HD wallets, not present for normal wallets.
    var extended_public_key: String = "" //The extended public key all addresses in the HD wallet are derived from. It's encoded in BIP32 format
    var subchain_indexes: [Int]? //optional returned for HD wallets created with subchains.
}

//An array of HDChains are included in every HDWallet and returned from the Get Wallet, Get Wallet Addresses and Derive Address in Wallet endpoints.
public struct HDChain: Codable {
    
    var chain_addresses: [HDAddress] = [] //Array of HDAddresses associated with this subchain.
    var index: Int? //optional Index of the subchain, returned if the wallet has subchains.
}


//An HD Address object contains an address and its BIP32 HD path (location of the address in the HD tree). It also contains the hex-encoded public key when returned from the Derive Address in Wallet endpoint.
public struct HDAddress: Codable {
    
    var address: String = "" //Standard address representation.
    var path: String = "" //The BIP32 path of the HD address.
    //original name: public
    var publicAddress: String? //optional Contains the hex-encoded public key if returned by Derive Address in Wallet endpoint.
}
