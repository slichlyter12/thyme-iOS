//
//  StepRowView.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/9/22.
//

import SwiftUI

struct StepRowView: View {
    
    var index: Int
    var step: String
    
    @State var isChecked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Group {
                    Text("\(index + 1): ")
                    Text(step).strikethrough(isChecked, color: .gray)
                }
                .foregroundColor(isChecked ? .gray : .primary)
                Spacer()
                Checkbox(checked: $isChecked)
            }
            Divider()
        }
    }
}

struct StepRowView_Previews: PreviewProvider {
    static var previews: some View {
        StepRowView(index: 0, step: "Shred cheese")
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
