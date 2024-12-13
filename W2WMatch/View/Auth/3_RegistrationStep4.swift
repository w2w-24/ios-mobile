//
//  RegistrationStep4.swift
//  W2WMatch
//
//  Created by Floron on 22.06.2024.
//

import SwiftUI

struct RegistrationStep4: View {
    @State var brand: CreateBrandRequestBody
    @State private var checked: [Bool]
    
    let optionsSubs = ["0 - 1.000",
                       "1.000 - 10.000",
                       "10.000 - 100.000",
                       "100.000 - 500.000",
                       "500.000+"]
    
    init(brand: CreateBrandRequestBody) {
        _checked = State(initialValue: [Bool](repeating: false, count: optionsSubs.count))
        self.brand = brand
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                    //Spacer()
                    
                    Text("Расскажите о своем\nбренде")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 34))
                        .multilineTextAlignment(.center)
                     
                    Spacer()
                    
                    VStack {
                        Text("Ссылка на страницу бренда в\nзапрещенной соц. сети")
                            .font(Font.custom("Manrope", size: 14))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wBlueColor"))
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        TextField(text: $brand.instBrandURL.animation()) {
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
//                        .padding(.bottom, 25.0)
                        
                        Text("Сколько подписчиков у Вашего бренда в запрещенной сети?")
                            .font(Font.custom("Manrope", size: 14))
                            .tracking(0.28)
                            .foregroundColor(Color("W2wBlueColor"))
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 15)
                        
                        Text("Выберите один вариант")
                            .font(Font.custom("Manrope", size: 12))
                            .tracking(0.28)
                            .foregroundColor(Color("SecondaryText"))
                            .padding(.bottom, 24)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(optionsSubs.indices, id: \.self) { index in
                            HStack {
                                CheckBoxView(checked: $checked[index], text: optionsSubs[index]) {
                                    checkOnlyOne(at: index)
                                    brand.subsCount = RequestQuestionType(text: optionsSubs[index], question: 10)
                                    //print(brand.subsCount)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 65.0)
                    //.frame(width: 358)
                    

                    NavigationLink(destination: RegistrationStep5(brand: brand)) {
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
    RegistrationStep4(brand: CreateBrandRequestBody())
}
