//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 20/07/2025.
//

import ThemeKit
import Foundation


struct DailyScrum: Identifiable {
    var id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    var lengInMinutesAsDouble: Double {
        get{
            return Double(lengthInMinutes)
        } set {
            lengthInMinutes = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), title: String, attendees: [Attendee], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum{
    struct Attendee: Identifiable {
        let id: UUID
        let name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}

extension DailyScrum {
    static var emptyScrum = DailyScrum(
        title: "",
        attendees: [],
        lengthInMinutes: 0,
        theme: .sky
    )
}

