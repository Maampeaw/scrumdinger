//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 20/07/2025.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.title
            configuration.icon
        }
    }
    
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingStyle: Self  { return Self() }
}
