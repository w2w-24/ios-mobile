//
//  RegistrationStep3.swift
//  W2WMatch
//
//  Created by Floron on 15.06.2024.
//

import SwiftUI

struct RegistrationStep3: View {
    
    @State var brand = CreateBrandRequestBody()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                   // Spacer()
                    
                    Text("Расскажите о своем\nбренде")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 34))
                        .multilineTextAlignment(.center)
                        
                     
                    //Spacer()
                    
                    VStack {
                        HStack {
                            Text("Название Вашего бренда и должность")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                            Spacer()
                        }
                        .padding(.top, 50)
                        
                        TextField(text: $brand.brandNamePos.animation()) {
                            Text("Название бренда")
                                .font(Font.custom("Manrope", size: 14).weight(.light))
                                .lineSpacing(20)
                                .foregroundColor(Color("W2wLightBlueColor"))
                        }
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .frame(width: 255, height: 45)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(
                            color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                        )
                        .foregroundStyle(Color("W2wLightBlueColor"))
//                        .padding()
//                        .frame(width: 255.0, height: 45.0)
//                        .overlay( /// apply a rounded border
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
//                        .foregroundStyle(Color("W2wLightBlueColor"))
//                        .padding(.bottom, 25.0)
                        
                       
                        HStack {
                            Text("Ссылка на Ваш телеграмм-канал или телеграмм-канал бренда")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        TextField(text: $brand.tgNickname.animation()) {
                            Text("@nic")
                                .font(Font.custom("Manrope", size: 14).weight(.light))
                                .lineSpacing(20)
                                .foregroundColor(Color("W2wLightBlueColor"))
                        }
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .frame(width: 255, height: 45)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(
                            color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                        )
                        .foregroundStyle(Color("W2wLightBlueColor"))
//                        .padding()
//                        .frame(width: 255.0, height: 45.0)
//                        .overlay( /// apply a rounded border
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
//                        .foregroundStyle(Color("W2wLightBlueColor"))
//                        .padding(.bottom, 25.0)
                        
                        HStack {
                            Text("Ссылка на сайт бренда или на маркетплейс (WB, OZON, Lamoda, Яндекс маркет)")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        TextField(text: $brand.brandSiteURL.animation()) {
                            Text("Ссылка")
                                .font(Font.custom("Manrope", size: 14).weight(.light))
                                .lineSpacing(20)
                                .foregroundColor(Color("W2wLightBlueColor"))
                        }
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        .frame(width: 255, height: 45)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(
                            color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                        )
                        .foregroundStyle(Color("W2wLightBlueColor"))
//                        .padding()
//                        .frame(width: 255.0, height: 45.0)
//                        .overlay( /// apply a rounded border
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
//                        .foregroundStyle(Color("W2wLightBlueColor"))
                      
                        
                    }
                    .padding(.horizontal, 65.0)
                    //.frame(width: 358)
                    

                    NavigationLink(destination: RegistrationStep4(brand: brand)) {
                        Text("Далее")
                    }
                    .frame(width: geometry.size.width - 120, height: 45.0)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("W2wLightBlueColor"))
                    }
                    .padding(.top)
                    
                    Image("Vector")
                        .padding(.top, 30.0)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationArrowLeft()
        .background(Color(red: 248, green: 248, blue: 248))
    }
}

#Preview {
    RegistrationStep3()
}
