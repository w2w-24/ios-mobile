//
//  PersonPhotoScreen.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 22.06.2024.
//

import SwiftUI

struct PersonPhotoScreen: View {
    private let brandView = BrandPictureSelecterView(photoItem: GalleryItem())
    @State var brand = CreateBrandRequestBody()
    @EnvironmentObject var mainVM: MainViewModel
   
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Ваше персональное фото")
                    .foregroundColor(Color("W2wBlueColor"))
                    .font(.custom("PoiretOne-Regular", size: 34))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 80)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 50)
                
                Text("Загрузите, пожалуйста, ваше фото")
                    .font(Font.custom("Manrope", size: 14))
                    .tracking(0.28)
                    .foregroundColor(Color("W2wBlueColor"))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                brandView
                
                Button("Готово") {
                    
                    if let data = brandView.photoItem.PhotoData {
                        
                        print("Что то есть")
                        
                        guard let stringFromData = data.convertingDataToBase64String else { return }

                        brand.photo = stringFromData
                       
                        // Включить после тестов
                        mainVM.createBrand(authBody: brand)
                        // Выключить после тестов
                        //mainVM.successfullRegistration = false
                    } else {
                        // allert
                        print("Фото не выбрано")
                    }
                }
                .frame(width: 250, height: 45.0)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("W2wLightBlueColor"))
                }
            
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
    PersonPhotoScreen()
}
