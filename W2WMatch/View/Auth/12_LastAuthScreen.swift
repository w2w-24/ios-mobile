//
//  LastAuthScreen.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 19.06.2024.
//

import SwiftUI

struct LastAuthScreen: View {
    
    @State private var brandView = BrandPictureSelecterView(photoItem: GalleryItem())
//    @State private var navigateToNextView = false
    @State var brand = CreateBrandRequestBody()
    

    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Остается только показать всем ваш продукт")
                    .foregroundColor(Color("W2wBlueColor"))
                    .font(.custom("PoiretOne-Regular", size: 34))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 80)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 50)
                
                Text("Загрузите, пожалуйста. фото, иллюстрирующее Ваш продукт (товар или услугу)")
                    .font(Font.custom("Manrope", size: 14))
                    .tracking(0.28)
                    .foregroundColor(Color("W2wBlueColor"))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                brandView
                
                NavigationLink(destination: LogoLoadScreen(brand: brand)) {
                    Text("Далее")
                }
                .frame(width: geometry.size.width - 120, height: 45.0)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("W2wLightBlueColor"))
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded{
                    if let data = brandView.photoItem.PhotoData {
                        
                        print("Что то есть")
                        
                        guard let stringFromData = data.convertingDataToBase64String else { return }

                        brand.productPhoto = stringFromData
                        print(brand.productPhoto.count)
                    } else {
                        // allert
                        print("Фото не выбрано")
                    }
                })

//                NavigationLink(destination: LogoLoadScreen(brand: brand), isActive: $navigateToNextView) {
//                    EmptyView()
//                }
                
//                Button("Далее") {
//                    print("Что то есть")
//                    if let data = brandView.photoItem.PhotoData {
//                        guard let stringFromData = data.convertingDataToBase64String else { return }
//
//                        brand.productPhoto = stringFromData
//                        //print(brand.productPhoto.count)
//                        self.navigateToNextView = true
//                    } else {
//                        // allert
//                        print("Фото не выбрано")
//                    }
//                }
//                .frame(width: 250, height: 45.0)
//                .foregroundStyle(.white)
//                .background {
//                    RoundedRectangle(cornerRadius: 15)
//                        .fill(Color("W2wLightBlueColor"))
//                }
            
                Image("Vector")
                    .padding(.top, 30)
                
                Spacer()
            }
            .frame(width: geometry.size.width - 120, height: geometry.size.height)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationArrowLeft()
        .background(Color(red: 248, green: 248, blue: 248))
    }
}

#Preview {
    LastAuthScreen()
}
