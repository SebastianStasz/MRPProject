//
//  Table.swift
//  MRPProject
//

import Foundation

struct Table {
    let title: String
    let items: [TableItem]
}

extension Table: Identifiable {
    var id: String { title }
}

// MARK: - Sample data

extension Table {
    static private var sampleItems: [TableItem] {
        [.sampleWeek,
         .sample(withTitle: "Całkowite zapotrzebowanie"),
         .sample(withTitle: "Planowane przyjęcia"),
         .sample(withTitle: "Przewidywane na stanie"),
         .sample(withTitle: "Zapotrzebowanie netto"),
         .sample(withTitle: "Planowane zamówienia"),
         .sample(withTitle: "Planowane przyjęcie zamówień")
        ]
    }
    
    static let sample = Table(title: "Title", items: sampleItems)
}
