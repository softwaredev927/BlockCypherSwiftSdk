//
//  AddressAPI.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 21/02/2020.
//

import Foundation

public class AddressAPI: BaseEndpoint {
    
    private let url = "addrs"
    
    //The Generate Address endpoint allows you to generate private-public key-pairs along with an associated public address.
    //No information is required with this POST request.
    public func generateAddressEndpoint(params: Dictionary<String, String>, completionHandler: @escaping (AddressKeyChain?, Int)->Void) {
        fetchPost(endpoint: self.url, queryParams: params, responseType: AddressKeyChain.self, completionHandler: completionHandler)
    }
    
    //The Generate Multisig Address Endpoint is a convenience method to help you generate multisig addresses from multiple public keys.
    //After supplying a partially filled-out AddressKeychain object (including only an array of hex-encoded public keys and the script type),
    // the returned object includes the computed public address.
    public func generateMultisigAddressEndpoint(addrKeyChain: AddressKeyChain, completionHandler: @escaping (AddressKeyChain?, Int)->Void) {
        fetchPost(endpoint: self.url, params: addrKeyChain, responseType: AddressKeyChain.self, completionHandler: completionHandler)
    }
    
    //The Address Balance Endpoint is the simplest---and fastest---method to get a subset of information on a public address.
    public func addressBalanceEndpoint(address: String, params: Dictionary<String, String>, completionHandler: @escaping (Address?, Int)->Void) {
        fetchGet(endpoint: "\(self.url)/\(address)/balance", params: params, responseType: Address.self, completionHandler: completionHandler)
    }
    
    //The default Address Endpoint strikes a balance between speed of response and data on Addresses.
    //It returns more information about an address' transactions than the Address Balance Endpoint
    // but doesn't return full transaction information (like the Address Full Endpoint).
    public func addressEndpoint(address: String, params: Dictionary<String, String>, completionHandler: @escaping (Address?, Int)->Void) {
        fetchGet(endpoint: "\(self.url)/\(address)", params: params, responseType: Address.self, completionHandler: completionHandler)
    }
    
    //The Address Full Endpoint returns all information available about a particular address,
    // including an array of complete transactions instead of just transaction inputs and outputs.
    //Unfortunately, because of the amount of data returned, it is the slowest of the address endpoints, but it returns the most detailed data record.
    public func addressFullEndpoint(address: String, params: Dictionary<String, String>, completionHandler: @escaping (Address?, Int)->Void) {
        fetchGet(endpoint: "\(self.url)/\(address)/full", params: params, responseType: Address.self, completionHandler: completionHandler)
    }
    
    public static let shared: AddressAPI = AddressAPI()
}
