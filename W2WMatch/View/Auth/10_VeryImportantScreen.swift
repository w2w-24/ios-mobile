//
//  InterectionFormatScreen.swift
//  W2WMatch
//
//  Created by Игорь Крысин on 17.06.2024.
//

import SwiftUI

struct VeryImportantScreen: View {
    
    @State var brand: CreateBrandRequestBody
    @State private var checked: [Bool]
    
    init(brand: CreateBrandRequestBody) {
        _checked = State(initialValue: [Bool](repeating: false, count: optionsGoals.count))
        self.brand = brand
    }
    
    let optionsGoals = ["Рост продаж",
                        "Повышение узнаваемости и лояльности",
                        "Новая аудитория и охваты в соцсетях",
                        "Совместное творчество и усиление навыков",
                        "Другое"]
                   
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Ваша цель для коллабораций")
                    .foregroundColor(Color("W2wBlueColor"))
                    .font(.custom("PoiretOne-Regular", size: 34))
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 80)
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 50)
                
                Text("Цель коллаборации")
                    .font(Font.custom("Manrope", size: 14))
                    .tracking(0.28)
                    .foregroundColor(Color("W2wBlueColor"))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Выберите один или несколько вариантов")
                    .font(Font.custom("Manrope", size: 12))
                    .tracking(0.28)
                    .foregroundColor(Color("SecondaryText"))
                    .padding(.bottom, 24)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
//                ForEach(optionsGoals, id: \.self) { option in
//                    TableRow(text: option) {
//                        
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
                
                ForEach(optionsGoals.indices, id: \.self) { index in
                    HStack {
                        CheckBoxView(checked: $checked[index], text: optionsGoals[index]) {
                            checked[index].toggle()
                        }
                    }
                }
                
                NavigationLink(destination: RegistrationStep11(brand: brand)) {
                    Text("Далее")
                }
                .frame(width: geometry.size.width - 120, height: 45.0)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("W2wLightBlueColor"))
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded {
                    for (index, value) in checked.enumerated() {
                        if value {
                            if brand.goals[0].text == "" {
                                brand.goals[0] = RequestQuestionType(text: optionsGoals[index], question: 18)
                            } else {
                                brand.goals.append(RequestQuestionType(text: optionsGoals[index], question: 18))
                            }
                        }
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
    VeryImportantScreen(brand: CreateBrandRequestBody())
}


