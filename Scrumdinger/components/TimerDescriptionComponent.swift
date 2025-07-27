//
//  TimerDescriptionComponent.swift
//  Scrumdinger
//
//  Created by Mark Amoah on 19/07/2025.
//

import Foundation
import SwiftUI

struct TimerDescriptionComponent: View{
    let title: String
    let timeValue: Int
    let imageString: String
    var labelStyle: TrailingIconLabelStyle?
    var alignment: HorizontalAlignment?
    
    var body: some View {
        VStack(alignment: alignment ?? .leading){
            Text("\(title)")
                .font(.caption)
            if let labelStyle = labelStyle{
                Label("\(Int(timeValue))", systemImage: imageString).labelStyle(labelStyle)
            }else{
                Label("\(Int(timeValue))", systemImage: imageString)
            }
            
        }
    }
    
    
}


#Preview {
    TimerDescriptionComponent(title: "Time Left", timeValue: 300, imageString: "hourglass.tophalf.fill", labelStyle: .trailingStyle)
}
