//
//  APIConfiguration.swift
//  MRPProject
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import Foundation

protocol APIConfigurationProtocol {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
}

struct APIConfiguration: APIConfigurationProtocol {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
}
