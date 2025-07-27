//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 25/07/2025.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers:[ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    var numberOfSpeakers:Int {
        speakers.count
    }
    
    private var speakerNumber: Int? {
           guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
           return index + 1
       }
    
    private var isLastSpeaker: Bool {
           return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakerText: String {
          guard let speakerNumber = speakerNumber else { return "No more speakers" }
          return "Speaker \(speakerNumber) of \(numberOfSpeakers)"
      }
    
    var body: some View {
        VStack {
            HStack{
                if isLastSpeaker{
                    Text("Last Speaker")
                }else{
                    Text(speakerText)
                    Spacer()
                    Button {
                        skipAction()
                    } label: {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Speaker")
                    
                }
               
                
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable var speakers = DailyScrum.sampleData[0].attendees
            .map { $0.name }
            .map { ScrumTimer.Speaker(name: $0, isCompleted: false) }
    MeetingFooterView(speakers: speakers) {
        
    }
}
