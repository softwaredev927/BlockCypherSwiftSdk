//
//  TXSkeleton.swift
//  BlockCypherSwiftSdk
//
//  Created by S.Bezpalyi on 22/02/2020.
//

import Foundation

//A TXSkeleton is a convenience/wrapper Object that's used primarily when Creating Transactions through the New and Send endpoints.
public struct TXSkeleton: Codable {
    
    //A temporary TX, usually returned fully filled but missing input scripts.
    public var tx: TX = TX()
    
    //of hex-encoded data for you to sign, one for each input.
    public var tosign: [String] = []
    
    //of signatures corresponding to all the data in tosign, typically provided by you.
    public var signatures: [String]?
    
    //of public keys corresponding to each signature. In general, these are provided by you, and correspond to the signatures you provide.
    public var pubkeys: [String]?
    
    //Optional Array of hex-encoded, work-in-progress transactions; optionally returned to validate the tosign data locally.
    public var tosign_tx: [String]?
    
    //Optional Array of errors in the form "error":"description-of-error".
    //This is only returned if there was an error in any stage of transaction generation, and is usually accompanied by a HTTP 400 code.
    public var errors: [InternalError]?
}

public struct InternalError: Codable {
    public var error: String = ""
}
