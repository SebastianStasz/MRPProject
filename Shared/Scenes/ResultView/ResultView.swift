//
//  ResultView.swift
//  MRPProject
//

import SwiftUI

struct ResultView: View {
    
    @State private var orientation = UIDevice.current.orientation
    let bedMRPResult: BedMRPResult
    
    var body: some View {
        ScrollView {
            VStack(spacing: .large) {
                tables
            }
            .padding(.top, 32)
        }
        .navigationTitle(String.result_label)
        .edgesIgnoringSafeArea(edges)
        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
    }
    
    private var tables: some View {
        ForEach(bedMRPResult.tables) { table in
            VStack(alignment: .leading, spacing: 4) {
                Text(table.title)
                    .bold()
                    .font(.title3)
                    .padding(.leading, .large)
                
                ResultTableView(items: table.items)
                    .embedInHorizontalScrollView()
            }
        }
    }

    var edges: Edge.Set {
        switch orientation {
        case .landscapeLeft:
            return [.trailing]
        case .landscapeRight:
            return [.leading]
        default:
            return []
        }
    }
}

// MARK: - Preview

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(bedMRPResult: <#T##BedMRPResult#>)
//    }
//}
