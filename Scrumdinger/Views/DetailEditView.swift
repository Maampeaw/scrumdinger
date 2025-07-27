//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 21/07/2025.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var attendeeName: String = ""
    let saveEdits: (DailyScrum)->Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form{
            Section(header: Text("Meeting Info")){
                TextField("Meeting Title", text: $scrum.title)
                HStack{
                    Slider(value: $scrum.lengInMinutesAsDouble,in: 5...30, step: 1){
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            
            
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees){ attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField("Attendee Name", text: $attendeeName)
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: attendeeName)
                            scrum.attendees.append(attendee)
                            attendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(attendeeName.isEmpty)

                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done"){
                    saveEdits(scrum)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var dailyScrum: DailyScrum = DailyScrum.emptyScrum
    DetailEditView(scrum: $dailyScrum){_ in }
}
