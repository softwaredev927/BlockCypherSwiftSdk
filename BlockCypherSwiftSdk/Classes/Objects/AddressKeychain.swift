//
//  AddressKeychain.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 21/02/2020.
//

import Foundation


//An AddressKeychain represents an associated collection of public and private keys alongside their respective public address. Generally returned and used with the Generate Address Endpoint.
public struct AddressKeyChain: Codable {
    
    public var address: String = "" //Standard address representation.
    
    //Hex-encoded Public key.
    
    public var publicKey: String = "" //original name: public
    
    //Hex-encoded Private key.
    public var privateKey: String = "" //original name: private
    
    //Wallet import format, a common encoding for the private key.
    public var wif: String = ""
    
    //Optional Array of public keys to provide to generate a multisig address.
    public var pubkeys: [String]? = []
    
    //Optional If generating a multisig address, the type of multisig script; typically "multisig-n-of-m", where n and m are integers.
    public var script_type: String?
    
    //Optional If generating an OAP address, this represents the parent blockchain's underlying address (the typical address listed above).
    public var original_address: String?
    
    //Optional The OAP address, if generated using the Generate Asset Address Endpoint.
    public var oap_address: String?
    
    private enum CodingKeys: String, CodingKey {
        case address
        case publicKey = "public"
        case privateKey = "private"
        case wif
        case pubkeys
        case script_type
        case original_address
        case oap_address
    }
}
