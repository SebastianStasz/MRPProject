//
//  BedResult.swift
//  MRPProject
//


import Foundation

struct BedResult: Decodable, Equatable {
    let expectedDemand: [Int]
    let production: [Int]
    let available: [Int]

    var table: Table {
        Table(title: "GHP", items: tableItems)
    }

    private var tableItems: [TableItem] {
        [
            .init(title: "Tydzień", values: Range(1...numOfWeeks).map { TableValue($0.description) }),
            .init(title: "Przewidywany popyt", values: expectedDemand.map { TableValue($0.description) }),
            .init(title: "Produkcja", values: production.map { TableValue($0.description) }),
            .init(title: "Dostępne", values: available.map { TableValue($0.description) }),
        ]
    }

    private var numOfWeeks: Int {
        expectedDemand.count
    }
}
