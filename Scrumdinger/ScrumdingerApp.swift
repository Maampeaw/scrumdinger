//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 19/07/2025.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums, )
        }
    }
}
