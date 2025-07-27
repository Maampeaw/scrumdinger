//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 21/07/2025.
//

import SwiftUI

struct DetailView: View {
    @Binding  var scrum: DailyScrum;
//    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false

    
    var body: some View {
        List{
            Section("Meeting Info") {
                
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(10)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            
            Section("Participants") {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
            }
            
            Section("History"){
                if (scrum.history.isEmpty){
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }else{
                    ForEach(scrum.history){ history in
                        HStack{
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
                
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack{
                DetailEditView(scrum: $scrum,){dailyScrum in
//                    self.scrum = editingScrum
                }
                    .navigationTitle(scrum.title)
    
            }
        }
        .toolbar {
            Button{
                isPresentingEditView = true
            } label: {
                Text("Edit")
                    
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum: DailyScrum = DailyScrum.emptyScrum
    NavigationStack {
        DetailView(scrum: $scrum)
    }
}
