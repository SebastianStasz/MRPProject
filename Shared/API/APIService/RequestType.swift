//
//  RequestType.swift
//  MRPProject
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import Foundation

public enum RequestType: String {
    case mrpCalculator = "https://infinite-dusk-35346.herokuapp.com"

    var baseURL: URL {
        URL(string: rawValue)!
    }
}
