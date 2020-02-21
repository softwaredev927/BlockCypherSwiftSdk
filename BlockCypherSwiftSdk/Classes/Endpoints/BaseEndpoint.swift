//
//  BaseEndpoint.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 21/02/2020.
//

import Foundation

public class BaseEndpoint {
    
    private let baseUrl = "https://api.blockcypher.com/v1/"
    
    func fetchUrl<T: Decodable>(endpoint: String, param: Encodable?, responseType: T.Type, completionHandler: @escaping (T?, Bool) -> Void) {
        let url = URL(string: "\(baseUrl)\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, false)
                return
            }
            do {
                let jsonData = try JSONDecoder().decode(responseType, from: data)
                completionHandler(jsonData, true)
            } catch let err {
                completionHandler(nil, false)
                print (err)
            }
        }
        
        task.resume()
    }
}
