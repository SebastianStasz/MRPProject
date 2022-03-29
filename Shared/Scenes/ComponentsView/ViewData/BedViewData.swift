//
//  BedViewData.swift
//  MRPProject
//

import Foundation

struct BedViewData: Equatable {
    var numberOfWeeks = 6 {
        didSet { weeksData = WeekData.forNumberOfWeeks(numberOfWeeks) }
    }
    var startAvaibility = 0
    var realizationTime = 1
    var weeksData: [WeekData] = WeekData.forNumberOfWeeks(6)
    var componentsData = ComponentsViewData()

    var isValid: Bool {
        weeksData.prefix(realizationTime)
            .map { $0.productionInput }
            .allSatisfy { $0 == 0 }
    }

    mutating func reset() {
        numberOfWeeks = 6
        startAvaibility = 0
        realizationTime = 1
        componentsData = .init()
    }

    var bedMRPModel: BedMRPModel {
        BedMRPModel(
            bed: bedModel,
            frame: componentsData.frame.model,
            stand: componentsData.stand.model,
            legs: componentsData.legs.model,
            smallBoards: componentsData.smallPlates.model,
            bigBoards: componentsData.bigPlates.model
        )
    }

    private var bedModel: BedModel {
        BedModel(
            startAvaibility: startAvaibility,
            realizationTime: realizationTime,
            expectedDemand: weeksData.map { $0.demandInput },
            production: weeksData.map { $0.productionInput }
        )
    }
}
