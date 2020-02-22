//
//  BaseEndpoint.swift
//  BlockCypherSwiftSdk
//
//  Created by Admin on 21/02/2020.
//

import Foundation

extension String {
    func URLEncodedString() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    static func queryStringFromParameters(parameters: Dictionary<String,String>) -> String {
        if (parameters.count == 0)
        {
            return ""
        }
        var queryString : String = ""
        for (key, value) in parameters {
            if let encodedKey = key.URLEncodedString() {
                if let encodedValue = value.URLEncodedString() {
                    if queryString == ""
                    {
                        queryString = "?"
                    }
                    else
                    {
                        queryString += "&"
                    }
                    queryString += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
}

public class BaseEndpoint {
    
    private var baseUrl = ""
    private let mainUrl = "https://api.blockcypher.com/v1/btc/main"
    private let testUrl = "https://api.blockcypher.com/v1/btc/test3"
    private var token = "d1bc2ab4cf154005908dc2e93db1d06e"
    
    init() {
        self.baseUrl = self.mainUrl
    }
    
    public func setLiveMode(live: Bool) {
        if live {
            self.baseUrl = self.mainUrl
        } else {
            self.baseUrl = self.testUrl
        }
    }
    
    public func setToken(token: String) {
        self.token = token
    }
    
    func fetchGet<T: Codable>(endpoint: String, params: Dictionary<String,String>, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint + String.queryStringFromParameters(parameters: params) , responseType: responseType, method: "GET", completionHandler: completionHandler)
    }
    
    func fetchPost<T: Codable>(endpoint: String, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint, responseType: responseType, method: "POST", completionHandler: completionHandler)
    }
    
    func fetchPost<T: Codable, T1: Codable>(endpoint: String, params: T1?, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint, params: params, responseType: responseType, method: "POST", completionHandler: completionHandler)
    }
    
    func fetchPost<T: Codable>(endpoint: String, jsonData: Dictionary<String, String>, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint, responseType: responseType, method: "POST", completionHandler: completionHandler)
    }
    
    func fetchPost<T: Codable, T1: Codable>(endpoint: String, queryParams: Dictionary<String, String>, params: T1?, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint + String.queryStringFromParameters(parameters: queryParams), params: params, responseType: responseType, method: "POST", completionHandler: completionHandler)
    }
    
    func fetchPost<T: Codable>(endpoint: String, queryParams: Dictionary<String, String>, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        fetchUrl(endpoint: endpoint + String.queryStringFromParameters(parameters: queryParams), responseType: responseType, method: "POST", completionHandler: completionHandler)
    }
    
    func fetchUrl<T: Codable>(request: URLRequest, endpoint: String, jsonData: Dictionary<String, String>, responseType: T.Type, method: String, completionHandler: @escaping (T?, Int) -> Void) {
        var request = createRequest(endpoint: endpoint, method: method)
        
        var body = "{"
        for val in jsonData {
            body += "\"\(val.key)\" : \"\(val.value)\""
        }
        body += "}"
        request.httpBody = body.data(using: .utf8)
        
        fetchResult(request: request, responseType: responseType, completionHandler: completionHandler)
    }
    
    func fetchUrl<T: Codable>(endpoint: String, responseType: T.Type, method: String, completionHandler: @escaping (T?, Int) -> Void) {
        let request = createRequest(endpoint: endpoint, method: method)
        
        fetchResult(request: request, responseType: responseType, completionHandler: completionHandler)
    }
    
    func fetchUrl<T: Codable, T1: Codable>(endpoint: String, params: T1?, responseType: T.Type, method: String, completionHandler: @escaping (T?, Int) -> Void) {
        var request = createRequest(endpoint: endpoint, method: method)
        
        if let params = params {
            do {
                let data = try JSONEncoder().encode(params)
                print (String(data: data, encoding: .utf8)!)
                request.httpBody = data
            } catch let err {
                completionHandler(nil, -1)
                print (err)
                return
            }
        }
        
        fetchResult(request: request, responseType: responseType, completionHandler: completionHandler)
    }
    
    private func createRequest(endpoint: String, method: String) -> URLRequest {
        var urlStr = "\(self.baseUrl)/\(endpoint)"
        if urlStr.contains("?") {
            urlStr += "&token=" + self.token
        } else {
            urlStr += "?token" + self.token
        }
        
        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
    private func fetchResult<T: Codable>(request: URLRequest, responseType: T.Type, completionHandler: @escaping (T?, Int) -> Void) {
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            var status = -1
            if let httpResponse = response as? HTTPURLResponse {
                status = httpResponse.statusCode
            }
            
            guard let data = data else {
                completionHandler(nil, status)
                return
            }
            do {
                let res = String(data: data, encoding: .utf8)!
                print (res)
                let jsonData = try JSONDecoder().decode(responseType, from: data)
                completionHandler(jsonData, status)
            } catch let err {
                completionHandler(nil, -2)
                print (err)
            }
        }
        
        task.resume()
    }
}
