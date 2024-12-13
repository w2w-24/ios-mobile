//
//  RegisterScreen.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 27.10.2022.
//

import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject var mainVm: MainViewModel
    
    @State var email = ""
    @State var password = ""
    @State var phone = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack() {
                    Image("logo vertical")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 175, height: 105)
                        //.padding(.top, 18.0)
                    
                    Text("Регистрация")
                        .foregroundColor(Color("W2wBlueColor"))
                        .font(.custom("PoiretOne-Regular", size: 38))
                    
                    Spacer()
                    
                    TextField(text: $email.animation()) {
                        Text("Ваш Email адрес")
                            .font(Font.custom("Manrope", size: 14).weight(.light))
                            .lineSpacing(20)
                            .foregroundColor(Color("W2wLightBlueColor"))
                    }
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .disabled(mainVm.registerPending)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .frame(width: 255, height: 45)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(
                        color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                    )
//                    .padding()
//                    .frame(width: 255.0, height: 45.0)
//                    .overlay( /// apply a rounded border
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
                    .foregroundStyle(Color("W2wLightBlueColor"))
                    
                    TextField(text: $phone.animation()) {
                        Text("Номер телефона (+7)")
                            .font(Font.custom("Manrope", size: 14).weight(.light))
                            .lineSpacing(20)
                            .foregroundColor(Color("W2wLightBlueColor"))
                    }
                    .textInputAutocapitalization(.never)
                    .keyboardType(.phonePad)
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .frame(width: 255, height: 45)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(
                        color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                    )
//                    .disabled(mainVm.registerPending)
//                    .padding()
//                    .frame(width: 255.0, height: 45.0)
//                    .overlay( /// apply a rounded border
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
                    .foregroundStyle(Color("W2wLightBlueColor"))
                    
                    SecureField(text: $password) {
                        Text("Пароль")
                            .font(Font.custom("Manrope", size: 14).weight(.light))
                            .lineSpacing(20)
                            .foregroundColor(Color("W2wLightBlueColor"))
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .disabled(mainVm.registerPending)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .frame(width: 255, height: 45)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(
                        color: Color(red: 0.46, green: 0.54, blue: 0.71, opacity: 0.2), radius: 12, x: 3, y: 3
                    )
//                    .padding()
//                    .frame(width: 255.0, height: 45.0)
//                    .overlay( /// apply a rounded border
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
                    .foregroundStyle(Color("W2wLightBlueColor"))
                    
                    
                    ZStack {
                        Button("Зарегистрировать") {
                            hideKeyboard()
                            if email.isEmpty {
                                mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                       title: "Invalid login",
                                                                       message: "Login can't be empty")
                                return
                            }
                            if password.count < 4 {
                                mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                       title: "Invalid password",
                                                                       message: "Password lenght must be 4 or more characters")
                                return
                            }
                            mainVm.register(email: email.lowercased(), phone: phone, password: password)
                        }
                        .disabled(mainVm.registerPending)
                        .frame(width: 255.0, height: 45.0)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("W2wLightBlueColor"))
                        }
                        .padding(.top)
                        
                        if mainVm.registerPending {
                             ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: Color("W2wLightBlueColor")))
                                 .scaleEffect(1)
                                 .padding(.top, 26)
                         }
                    }
                 
                    HStack {
                        Text("У меня уже есть аккаунт")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top, 0.0)
                        
                        
                        NavigationLink(destination: LoginScreen()) {
                            Text("Войти")
                                .foregroundColor(Color(uiColor: .darkGray))
                        }
                    }.padding(.top, 10.0)
                    
                    Spacer()
                    
                    Image("Vector")
                        .padding(.top, 8.0)
                    Text("Войти с помощью")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 0.0)
                    
                    Image("social")
                        .padding(.top, 8.0)
                  
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationArrowLeft()
        .background(Color.white.ignoresSafeArea())
        .alert(item: $mainVm.alert) { alert in
            alert.alert()
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
