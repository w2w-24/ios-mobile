//
//  RegistrationStep7.swift
//  W2WMatch
//
//  Created by Floron on 22.06.2024.
//

import SwiftUI

struct RegistrationStep7: View {
    
    @State var brand: CreateBrandRequestBody
    @State private var checked: [Bool]
    
    let optionsPresenceType = ["Online",
                               "Offline",
                               "Оба варианта"]
    
    init(brand: CreateBrandRequestBody) {
        _checked = State(initialValue: [Bool](repeating: false, count: optionsPresenceType.count))
        self.brand = brand
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                    Spacer()
                    
                    Text("Расскажите\nо своем бизнесе")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 34))
                        .multilineTextAlignment(.center)
                    
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("У вас online или offline бренд?")
                            .font(Font.custom("Manrope", size: 14))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wBlueColor"))
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("Выберите один вариант")
                            .font(Font.custom("Manrope", size: 12))
                            .tracking(0.28)
                            .foregroundColor(Color("SecondaryText"))
                            .padding(.bottom, 24)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(optionsPresenceType.indices, id: \.self) { index in
                            HStack {
                                CheckBoxView(checked: $checked[index], text: optionsPresenceType[index]) {
                                    checkOnlyOne(at: index)
                                    brand.presenceType = RequestQuestionType(text: optionsPresenceType[index], question: 7)
                                }
                            }
                        }
                        
                        
                        HStack {
                            Text("Состоите ли вы в каком-то комьюнити/сообществе предпринимателей? Напишите, пожалуйста, название или добавьте ссылку на сообщество")
                                .font(Font.custom("Manrope", size: 14))
                                .tracking(0.28)
                                .foregroundColor(Color("W2wBlueColor"))
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.bottom)
                        
                        TextField(text: $brand.businessGroup.animation()) {
                            Text("Ваш вариант")
                                .font(Font.custom("Manrope", size: 14).weight(.light))
                                .lineSpacing(20)
                                .foregroundColor(Color("W2wLightBlueColor"))
                        }
                        .textInputAutocapitalization(.never)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                        .padding()
                        .frame(width: 255.0, height: 45.0)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
                        .foregroundStyle(Color("W2wLightBlueColor"))
                        
                        
                    }
                    .padding(.horizontal, 65.0)
                    //.frame(width: 358)
                    
                    //Spacer()
                    
                    NavigationLink(destination: RegistrationStep8(brand: brand)) {
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
                        .padding(.top, 38.0)
                    
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
    RegistrationStep7(brand: CreateBrandRequestBody())
}


