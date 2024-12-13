import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    var text: String
    var onToggle: () -> Void
    
    var body: some View {
        
            HStack {
                Image(systemName: checked ? "checkmark.square" : "square")
                    .foregroundColor(checked ? Color("CheckGreen") : Color("FrameRegistration"))
                    .padding(.leading, 5)
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
    
//    func checkOnlyOne(at index: Int, checked: inout [Bool]) {
//        for i in checked.indices {
//            checked[i] = (i == index)
//        }
//    }
    
}
