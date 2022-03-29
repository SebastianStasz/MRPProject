//
//  GetBedMRPRequest.swift
//  MRPProject
//

import Foundation

struct GetBedMRPRequest: APIRequest {
    let method: RequestMethod = .POST
    let path: String = "/api/tables"
    let body: Encodable?
    
    init(body: BedMRPModel) {
        self.body = body
    }
}
