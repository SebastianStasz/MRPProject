//
//  ResultTableView.swift
//  MRPProject
//
//  Created by sebastianstaszczyk on 15/03/2022.
//

import SwiftUI

struct ResultTableView: View {
    
    let items: [TableItem]
    
    var body: some View {
        LazyVGrid(columns: gridLayout, spacing: 0) {
            ForEach(items) { item in
                CellView(text: item.title, isBold: true, alignment: .leading)
                ForEach(item.values) { value in
                    CellView(text: value.value, isBold: item.title == "Tydzień", alignment: .center)
                }
            }
        }
        .background(Color.gray)
        .padding(.large)
    }
    
    private var gridLayout: [GridItem] {
        let title = GridItem.init(.flexible(minimum: 170), spacing: 0)
        var items = Array(repeating: GridItem.init(.fixed(90), spacing: 0), count: items.first?.values.count ?? 0)
        items.insert(title, at: 0)
        return items
    }
}


// MARK: - Preview

struct ResultTableView_Previews: PreviewProvider {
    static var previews: some View {
        ResultTableView(items: Table.sample.items)
    }
}
