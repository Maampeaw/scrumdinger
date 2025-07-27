//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 24/07/2025.
//

import SwiftUI
import ThemeKit

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int{
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else {
            return 1
        }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ProgressView(value:progress).progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack{
                TimerDescriptionComponent(title: "Seconds Elapsed", timeValue: secondsElapsed, imageString: "hourglass.tophalf.fill")
                Spacer()
                TimerDescriptionComponent(title: "Seconds Left", timeValue: secondsRemaining, imageString: "hourglass.bottomhalf.fill", labelStyle: .trailingStyle, alignment: .trailing)
            }
            
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time Remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 2, secondsRemaining: 10, theme: .bubblegum)
}
