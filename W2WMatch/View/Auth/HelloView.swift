//
//  ContentView.swift
//  W2WMatch
//
//  Created by Floron on 02.06.2024.
//

import SwiftUI

struct HelloView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Image("helloArms")
                    .padding(.top, 88.0)
                
                Text("Добро пожаловать в сервис коллабораций для брендов")
                    .foregroundColor(Color("W2wBlueColor"))
                    .font(.custom("PoiretOne-Regular", size: 35))
                    .multilineTextAlignment(.center)
                    .padding(.top, 36.0)
                    .padding(.horizontal, 20)
               
                //Spacer()
                
                HStack {
                    NavigationLink("Вход") {
                        LoginScreen()
                    }
                    .padding()
                    .frame(width: 150.0, height: 45.0)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("W2wLightBlueColor"))
                    }

                    NavigationLink("Регистрация") {
                        RegisterScreen()
                    }
                    .padding()
                    .frame(width: 150.0, height: 45.0)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("W2wLightBlueColor"), lineWidth: 2))
                    .foregroundStyle(Color("W2wLightBlueColor"))
                }.padding(.top, 70.0)
                
                
                
                Spacer()
                
                
                Image("Vector")
                    .padding(.top, 8.0)
                Text("Войти с помощью")
                    .foregroundColor(.gray)
                    //.foregroundStyle(Color(cgColor: CGColor(red: 12.0, green: 12.0, blue: 12.0, alpha: 1)))
                    .multilineTextAlignment(.center)
                    .padding(.top, 0.0)
                
                Image("social")
                    .padding(.top, 8.0)
                Spacer()
            }
        }
    }
}
            
            //.font(.custom("Felidae-Regular", size: 22))
            
//            Button("Телеграмм") {
//                print("Кнопка Телеграмм нажата")
//                
////                let botURL = URL.init(string: "tg://resolve?domain=academeg_true_original")
////
////                if UIApplication.shared.canOpenURL(botURL!) {
////                    UIApplication.shared.openURL(botURL!)
////                } else {
////                  // Telegram is not installed.
////                }
//                
//                let screenName =  "academeg_true_original" // <<< ONLY CHANGE THIS ID
//                let appURL = NSURL(string: "tg://resolve?domain=\(screenName)")!
//                let webURL = NSURL(string: "https://t.me/\(screenName)")!
//                if UIApplication.shared.canOpenURL(appURL as URL) {
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
//                    }
//                    else {
//                        UIApplication.shared.openURL(appURL as URL)
//                    }
//                }
//                else {
//                    //redirect to safari because user doesn't have Telegram
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
//                    }
//                    else {
//                        UIApplication.shared.openURL(webURL as URL)
//                    }
//                }
//                
//                
//            }
//            .padding()
//            .frame(width: 150.0, height: 45.0)
//            .overlay( /// apply a rounded border
//                RoundedRectangle(cornerRadius: 15)
//                    .stroke(/*@START_MENU_TOKEN@*/Color("W2wBlueColor")/*@END_MENU_TOKEN@*/, lineWidth: 2))
//            .foregroundStyle(/*@START_MENU_TOKEN@*/Color("W2wBlueColor")/*@END_MENU_TOKEN@*/)


#Preview {
    HelloView()
}
