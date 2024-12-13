//
//  RegistrationStep2.swift
//  W2WMatch
//
//  Created by Floron on 15.06.2024.
//

import SwiftUI

struct RegistrationStep2: View {
    @State var brand = CreateBrandRequestBody()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack {
                    
                    Text("Отлично!")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 38))
                    
                    Spacer()
                    
                    VStack {
                        Text("Для того, что мы помогли тебе сразу найти партнера, ответь на вопросы")
                        .font(Font.custom("Manrope", size: 14))
                        .multilineTextAlignment(.leading)
                        .tracking(0.28)
                        .foregroundColor(Color("W2wBlueColor"))
                        
                        
                        Text("Ответы займут 10-15 минут. Можешь вернуться\nк завершению регистрации позже. Если переживаешь,что забудешь - оставь свой номер телефона, мы напомним.")
                            .font(Font.custom("Manrope", size: 12))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wLightBlueColor"))
                            .padding(.top, 5.0)
                            .padding(.bottom, 45.0)
                        
                        
                        HStack {
                            Text("Ваше имя и фамилия")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                                
                            Spacer()
                        }
                        
                        TextField(text: $brand.fullname.animation()) {
                            Text("Имя и фамилия")
                                .font(Font.custom("Manrope", size: 12).weight(.medium))
                                .tracking(0.24)
                                .foregroundColor(.w2WLightBlue)
                        }
                        .textInputAutocapitalization(.words)
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
                       
                        HStack {
                            Text("Ваш никнэйм в Телеграмм")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                            Spacer()
                        }
                        .padding(.top, 25)
                        
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
                      
                        
                    }
                    .padding(.horizontal, 50.0)
                    .frame(width: 358)
                    
                    
                    NavigationLink(destination: RegistrationStep3(brand: brand)) {
                        Text("Далее")
                    }
                    .frame(width: 255.0, height: 45.0)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("W2wLightBlueColor"))
                    }
                    .padding(.top)
                    
                    Image("Vector")
                        .padding(.top, 30.0)
                    
                    Spacer()
 
                    Button(action: {
                        print("В разработке")
                    }) {
                        Text("Перезвоните мне, пожалуйста")
                            .font(Font.custom("Manrope", size: 14).weight(.medium))
                            .lineSpacing(18.20)
                            .foregroundColor(.gray)
                    }
                    
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
    RegistrationStep2()
}
