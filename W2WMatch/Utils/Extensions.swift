//
//  Extensions.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 27.10.2022.
//

import Foundation
import SwiftUI


struct NavigationArrowLeft: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("W2wBlueColor"))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
    }
}

extension View {
    func navigationArrowLeft() -> some View {
        modifier(NavigationArrowLeft())
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension HTTPURLResponse {
    
    func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}

extension Date {
    
    init(timestampMillis: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timestampMillis/1000))
    }
    
    func timestampMillis() -> Int64 {
        return timestamp() * 1000
    }
    
    func timestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension Data {
    var convertingDataToBase64String: String? {
        if let uiImage = UIImage(data: self) {
           
            guard let base64 = uiImage.base64 else { return  "" }
            
            //print("base 64 string: ", base64)
            return base64
      
        }
        return ""
    }
}
//
//extension String {
//    var imageFromBase64: UIImage? {
//        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
//            return nil
//        }
//        return UIImage(data: imageData)
//    }
//}
