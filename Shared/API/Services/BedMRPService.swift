//
//  BedMRPService.swift
//  MRPProject
//

import Combine
import Foundation

final class BedMRPService {

    private let apiService = APIService.shared
    
    func calculateBedMRP(for model: BedMRPModel) -> AnyPublisher<BedMRPResult, APIError> {
        print("Send: \(model)")
        return apiService.performRequest(GetBedMRPRequest(body: model), type: .mrpCalculator)
    }
}
