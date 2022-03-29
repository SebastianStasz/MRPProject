//
//  ComponentResult.swift
//  MRPProject
//

import Foundation

struct ComponentResult: Decodable, Equatable {
    let type: ComponentType
    let totalDemand: [Int]
    let plannedReceipts: [Int]
    let expectedInStock: [Int]
    let netDemand: [Int]
    let plannedOrders: [Int]
    let plannedOrderIntake: [Int]
}

extension ComponentResult {
    var table: Table {
        Table(title: "MRP: \(type.title)", items: tableItems)
    }
    
    private var numOfWeeks: Int {
        totalDemand.count
    }
    
    private var tableItems: [TableItem] {
        [
        .init(title: "Tydzień", values: Range(1...numOfWeeks).map { TableValue($0.description) }),
        .init(title: "Całkowite zapotrzebowanie", values: totalDemand.map { TableValue($0.description) }),
        .init(title: "Planowane przyjęcia", values: plannedReceipts.map { TableValue($0.description) }),
        .init(title: "Przewidywane na stanie", values: expectedInStock.map { TableValue($0.description) }),
        .init(title: "Zapotrzebowanie netto", values: netDemand.map { TableValue($0.description) }),
        .init(title: "Planowane zamówienia", values: plannedOrders.map { TableValue($0.description) }),
        .init(title: "Planowane przyjęcie zamówień", values: plannedOrderIntake.map { TableValue($0.description) }),
        ]
    }
}
