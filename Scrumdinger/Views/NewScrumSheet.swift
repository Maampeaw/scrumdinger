//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 25/07/2025.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum: DailyScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack{
            DetailEditView(scrum: $newScrum) { createdScrum in
                scrums.append(createdScrum)
            }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}
