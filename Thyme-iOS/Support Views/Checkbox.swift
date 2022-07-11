//
//  Checkbox.swift
//  Thyme-iOS
//
//  Created by Samuel Lichlyter on 7/8/22.
//

import SwiftUI

struct Checkbox: View {
    @Binding var checked: Bool
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color.accentColor : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct Checkbox_Preview: PreviewProvider {
    
    struct CheckboxPreview: View {
        @State var checked: Bool = true
        @State var notChecked: Bool = false
        
        var body: some View {
            Checkbox(checked: $checked)
            Checkbox(checked: $notChecked)
        }
    }
    
    static var previews: some View {
        CheckboxPreview()
            .previewLayout(.fixed(width: 80, height: 80))
    }
}
