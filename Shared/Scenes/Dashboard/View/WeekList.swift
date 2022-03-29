//
//  WeekList.swift
//  MRPProject (iOS)
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import SwiftUI

struct WeekList: View {

    @Binding var weeksData: [WeekData]

    var body: some View {
        ForEach($weeksData, content: WeekInput.init)
    }
}

// MARK: - Preview

struct WeekList_Previews: PreviewProvider {
    static var previews: some View {
        WeekList(weeksData: .constant(WeekData.forNumberOfWeeks(2)))
    }
}
