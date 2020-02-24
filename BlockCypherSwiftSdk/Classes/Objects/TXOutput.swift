//
//  TXOutput.swift
//  Amadeus
//
//  Created by S.Bezpalyi on 21/02/2020.
//  Copyright © 2020 IdeaByNature. All rights reserved.
//

import Foundation

//A TXOutput represents an output created by a transaction. Typically found within an array in a TX.
public struct TXOutput: Codable {
    
    public init() {
    }
    
    //Value in this transaction output, in satoshis.
    public var value: Int64 = 0
    
    //Raw hexadecimal encoding of the encumbrance script for this output.
    public var script: String?
    
    //Addresses that correspond to this output; typically this will only have a single address,
    // and you can think of this output as having "sent" value to the address contained herein.
    public var addresses: [String] = []
    
    //The type of encumbrance script used for this output.
    public var script_type: String?
    
    //Optional The transaction hash that spent this output. Only returned for outputs that have been spent.
    //The spending transaction may be unconfirmed.
    public var spent_by: String?
    
    //Optional A hex-encoded representation of an OP_RETURN data output, without any other script instructions.
    //Only returned for outputs whose script_type is null-data.
    public var data_hex: String?
    
    //Optional An ASCII representation of an OP_RETURN data output, without any other script instructions.
    //Only returned for outputs whose script_type is null-data and if its data falls into the visible ASCII range.
    public var data_string: String?
}
