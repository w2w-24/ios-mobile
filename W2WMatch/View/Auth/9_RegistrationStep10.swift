//
//  RegistrationStep10.swift
//  W2WMatch
//
//  Created by Floron on 22.06.2024.
//

import SwiftUI

struct RegistrationStep10: View {

    @State var brand: CreateBrandRequestBody
    @State private var checked: [Bool]
    
    let optionsPublicSpeaker = ["Да",
                                "Нет"]
    
    init(brand: CreateBrandRequestBody) {
        _checked = State(initialValue: [Bool](repeating: false, count: optionsPublicSpeaker.count))
        self.brand = brand
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                    //Spacer()
                    
                    Text("Чем Вы можете быть полезны другим?")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 34))
                        .multilineTextAlignment(.center)
                        
                     
                   // Spacer()
                    
                    VStack {
                        
                        Text("На какие темы с Вами можно пообщаться? Или по каким темам Вы можете дать рекомендации?")
                            .font(Font.custom("Manrope", size: 14))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wBlueColor"))
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 48)
                        
                        TextField(text: $brand.topics.animation()) {
                            Text("Перечислите темы")
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
//                        .overlay( /// apply a rounded border
//                            RoundedRectangle(cornerRadius: 15)
//                        .stroke(Color("FrameRegistration"), lineWidth: 2))
//                        .foregroundStyle(Color("FrameRegistration"))
//                        .padding(.bottom, 25.0)

                        Text("Готовы ли вы быть спикером прямого эфира или участвовать в публичном выступлении для резидентов?")
                            .font(Font.custom("Manrope", size: 14))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wBlueColor"))
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 8)
                        
//                        ForEach(optionsPublicSpeaker, id: \.self) { option in
//                            TableRow(text: option)
//                            {}
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
                        
                        ForEach(optionsPublicSpeaker.indices, id: \.self) { index in
                            HStack {
                                CheckBoxView(checked: $checked[index], text: optionsPublicSpeaker[index]) {
                                    checkOnlyOne(at: index)
                                    //CheckBoxView().checkOnlyOne(at: index, checked: &checked)
                                    brand.publicSpeaker = RequestQuestionType(text: optionsPublicSpeaker[index], question: 9)
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 65.0)
                    //.frame(width: 358)
                    
                    //Spacer()
                    
                    NavigationLink(destination: VeryImportantScreen(brand: brand)) {
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
    
    private func checkOnlyOne(at index: Int) {
        for i in checked.indices {
            checked[i] = (i == index)
        }
    }
}

#Preview {
    RegistrationStep10(brand: CreateBrandRequestBody())
}
