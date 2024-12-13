//
//  PhotoView.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 19.06.2024.
//

import SwiftUI

struct PhotoView: View {
    var photoData: Data?
    //@State var text = ""
    //@EnvironmentObject var mainVm: MainViewModel
    
    var body: some View {
        if let photoData = photoData, let uiImage = UIImage(data: photoData) {
            let imageSize = 80.00
            
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .cornerRadius(10)
                .offset(y: -10)
            
        } 
            //else {
//            let imageSize = 100.00
//            
//            Image(.downloadImageView)
//                .foregroundColor(.accentColor)
//                .font(.system(size: imageSize))
//        }
//        NavigationLink(destination: LastAuthScreen(photoData: photoData, user: AutorizedUser())) {
//                      
//                   }
//                   .disabled(photoData == nil)
        
    }
}

//#Preview {
//    PhotoView( completion: <#() -> ()?#>)
//}




