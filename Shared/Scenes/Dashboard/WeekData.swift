//
//  WeekData.swift
//  MRPProject
//
//  Created by sebastianstaszczyk on 14/03/2022.
//

import Foundation

struct WeekData: Equatable {
    let weekNumber: Int
    var demandInput = 0
    var productionInput = 0
}

extension WeekData: Identifiable {
    var id: Int { weekNumber }
}

extension WeekData {
    static func forNumberOfWeeks(_ count: Int) -> [WeekData] {
        let count = count > 0 ? count : 1
        return Range(1...count).map { WeekData(weekNumber: $0) }
    }
}
