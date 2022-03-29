//
//  URLRequest+Ext.swift
//  MRPProject
//

import Foundation

extension URLRequest {
    mutating func addHTTPHeaders(_ headers: [String: String]) {
        for (key, value) in headers {
            addValue(value, forHTTPHeaderField: key)
        }
    }
}
