//
//  LoginScreen.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 27.10.2022.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var mainVm: MainViewModel
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack {
                    
                    HStack {
                        Spacer()
                        ZStack {
                            Image("RegistrationVector1")
                            Image("RegistrationVector2")
                                .padding(.top, -55.0)
                                .padding(.trailing, 15.0)
                            Image("RegistrationVector3")
                                .padding(.top, 43.0)
                                .padding(.trailing, 65.0)
                            
                        }.padding(.trailing, 15.0)
                    }
                    
                    Image("logo vertical")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 78)
                        .padding(.top, 18.0)
                    
                    Text("Авторизация")
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
                    .disabled(mainVm.loginPending)
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
                    
                    
                    SecureField(text: $password) {
                        Text("Пароль")
                            .font(Font.custom("Manrope", size: 14).weight(.light))
                            .lineSpacing(20)
                            .foregroundColor(Color("W2wLightBlueColor"))
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .disabled(mainVm.loginPending)
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
                        Button("Войти") {
                            hideKeyboard()
                            if email.isEmpty {
                                mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                       title: "Invalid login",
                                                                       message: "Login can't be empty")
                                return
                            }
                            if password.count < 8 {
                                mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                       title: "Invalid password",
                                                                       message: "Password lenght must be 4 or more characters")
                                return
                            }
                            mainVm.login(email: email.lowercased(), password: password)
                        }
                        .disabled(mainVm.loginPending)
                        .frame(width: 255.0, height: 45.0)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("W2wLightBlueColor"))
                        }
                        .padding(.top)
                        
                        if mainVm.loginPending {
                             ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: Color("W2wLightBlueColor")))
                                 .scaleEffect(1)
                                 .padding(.top, 26)
                         }
                    }
                    
                    
                    Button(action: {
                        print("В разработке")
                    }) {
                        Text("Забыли пароль?")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image("Vector")
                        .padding(.top, 8.0)
                    Text("Войти с помощью")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 0.0)
                    
                    Image("social")
                        .padding(.top, 8.0)
                    
                
                    HStack {
                        Text("Нет аккаунта?")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top, 0.0)
                        
                        
                        NavigationLink(destination: RegisterScreen()) {
                            Text("Зарегистрируйтесь")
                                .foregroundColor(Color(uiColor: .darkGray))
                        }
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationArrowLeft()
        .background(Color(red: 248, green: 248, blue: 248))
        .alert(item: $mainVm.alert) { alert in
            alert.alert()
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
