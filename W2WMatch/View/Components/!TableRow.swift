//
//  TableRow.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 17.06.2024.
//

import SwiftUI

struct TableRow: View {
    @State var isChecked: Bool = false
    var text: String
    var onToggle: () -> Void
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isChecked)
                .toggleStyle(CheckBoxToggelStyle())
                .padding(.leading, 0)
                .onTapGesture {
                    self.onToggle()
                }
            
                Text(text)
                    .foregroundColor(Color("W2wBlueColor"))
                    .padding(.leading, 0)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font.custom("Manrope", size: 14).weight(.ultraLight))
            
            Spacer()
            
           
        }
        .padding(.trailing, 0)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 2)
            
        )
    }
}

struct CheckBoxToggelStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(configuration.isOn ? Color("CheckGreen") : Color("FrameRegistration"))
                    .padding(.leading, 5)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    TableRow(text: "ddddd"){
        
    }
}
