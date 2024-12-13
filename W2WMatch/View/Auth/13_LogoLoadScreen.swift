//
//  LogoLoadScreen.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 20.06.2024.
//

import SwiftUI

struct LogoLoadScreen: View {
    private let brandView = BrandPictureSelecterView(photoItem: GalleryItem())
    @State var brand = CreateBrandRequestBody()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Ваш логотип")
                    .foregroundColor(Color("W2wBlueColor"))
                    .font(.custom("PoiretOne-Regular", size: 34))
                    .multilineTextAlignment(.center)
                    
                    .frame(width: geometry.size.width - 80)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 50)
                
                Text("Загрузите, пожалуйста, логотип вашего бренда")
                    .font(Font.custom("Manrope", size: 14))
                    .tracking(0.28)
                    .foregroundColor(Color("W2wBlueColor"))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                brandView
                
                NavigationLink(destination: PersonPhotoScreen(brand: brand)) {
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
                    
                        brand.logo = stringFromData
                    } else {
                        // allert
                        print("Фото не выбрано")
                    }
                })
                
               
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
    LogoLoadScreen()
}
