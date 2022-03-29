//
//  ValidationMessage.swift
//  MRPProject (iOS)
//
//  Created by sebastianstaszczyk on 29/03/2022.
//

import SwiftUI

struct ValidationMessage: View {

    private let message: String

    init(_ message: String) {
        self.message = message
    }

    var body: some View {
        Text(message)
            .font(.caption)
            .foregroundColor(.red)
    }
}

// MARK: - Preview

struct ValidationMessage_Previews: PreviewProvider {
    static var previews: some View {
        ValidationMessage("Sample validation message")
    }
}
