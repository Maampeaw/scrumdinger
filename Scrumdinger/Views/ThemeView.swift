//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 21/07/2025.
//

import SwiftUI
import ThemeKit

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundStyle(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}
