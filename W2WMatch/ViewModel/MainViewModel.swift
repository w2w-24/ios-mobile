//
//  MainViewModel.swift
//  jwt_authorizer
//
//  Created by Lev Baklanov on 28.10.2022.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    // показ экранов
    @Published var showAuthContainer = true
    @Published var successfullRegistration = false
 
    @Published var loginPending = false
    @Published var registerPending = false
    
    
    @Published var paymentList: [PaymentListElement] = []
    @Published var brandsArray: [CreateBrandResponse] = []
    // для проверки
    @Published var brandAuthBody = CreateBrandRequestBody(category: RequestQuestionType(text: "Красота и здоровье", question: 4),
                                                          presenceType: RequestQuestionType(text: "Online", question: 7),
                                                          publicSpeaker: RequestQuestionType(text: "Да", question: 9),
                                                          subsCount: RequestQuestionType(text: "100.000 - 500.000", question: 10),
                                                          avgBill: RequestQuestionType(text: "1.000 - 10.000", question: 11),
                                                          goals: [RequestQuestionType(text: "Рост продаж", question: 18)],
                                                          formats: [RequestQuestionType(text: "Совместный reels", question: 17)],
                                                          collaborationInterest: [RequestQuestionType(text: "Я открыта к экспериментам и категория партнера мне не важна", question: 19)],
                                                          tgNickname: "@Valentin",
                                                          brandNamePos: "Valenki",
                                                          instBrandURL: "inst://valenochki",
                                                          brandSiteURL: "http://www.valenochki.ru",
                                                          topics: "хз что это",
                                                          missionStatement: "хз",
                                                          targetAudience: "хз",
                                                          uniqueProductIs: "Из шерсти жопы бобра",
                                                          productDescription: "Побреем все бобринные жопки)",
                                                          problemSolving: "Бобры остаются целыми",
                                                          businessGroup: "Нет",  // "Состоите ли вы в каком-то комьюнити/сообществе предпринимателей? Напишите, пожалуйста, название или добавьте ссылку на сообщество"
                                                          logo: image64,
                                                          photo: image64,
                                                          productPhoto: image64,
                                                          fullname: "Валентин Сидоров")
//    @Published var devsProgress: LoadingState = .notStarted
//    @Published var developers: [Developer] = []
    
    @Published var alert: IdentifiableAlert?
    
    init() {
        let refreshToken = UserDefaultsWorker.shared.getRefreshToken()
        if !refreshToken.token.isEmpty && refreshToken.expiresAt > Date().timestampMillis() {
            showAuthContainer = false
            
//        успешно создался бренд
//        self.createBrand(authBody: brandAuthBody)
//        self.getAnketa()
        }
    }
    
    func logout() {
        UserDefaultsWorker.shared.dropTokens()
        Requester.shared.dropTokens()
        withAnimation {
            showAuthContainer = true
        }
    }
    
    func login(email: String, password: String) {
        withAnimation {
            loginPending = true
        }
        print("login called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.login(authBody: AuthBody(email: email, password: password, phone: "")) { [self] result in
                print("login response: \(result)")
                withAnimation {
                    loginPending = false
                }
                switch result {
                case .success(_):
                    withAnimation {
                        self.showAuthContainer = false
                    }
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_err", message: Errors.messageFor(err: err.message))
                }
            }
        }
    }
    
    func register(email: String, phone: String, password: String) {
        withAnimation {
            registerPending = true
        }
        print("register called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.register(authBody: AuthBody(email: email, password: password, phone: phone)) { [self] result in
                print("register response: \(result)")
                withAnimation {
                    registerPending = false
                }
                switch result {
                case .success(_):
                    // do something with user
                    withAnimation {
                        // show RegistrationStep2()
                        self.successfullRegistration = true
                        self.showAuthContainer = false
                    }
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_err", message: Errors.messageFor(err: err.message))
                }
            }
        }
    }
    
    
    func createBrand(authBody: CreateBrandRequestBody) {
        print("create Brand called")
        
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.brandCreate(authBody: authBody) { [self] result in
                print("create Brand response: \(result)")
                
                switch result {
                case .success(_):
                    self.successfullRegistration = false
                    //print(brand)
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    print(err)
                }
            }
        }
    }
    
    func getBrands() {
        print("create Brand called")
        
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.getAllBrands() { [self] result in
                print("get All Brands response: \(result)")
                
                switch result {
                case .success(let brandsList):
                    brandsArray = brandsList
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    print(err)
                }
            }
        }
    }
    
    
    // метод работает, присылает анкету
    func getAnketa() {
      
        print("get Anketa called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.getAnketa() { [self] result in
                print("get Anketa response: \(result)")
               
                switch result {
                case .success(let anketa):
                    print(anketa)
                    print("Success")
                case .serverError(let err):
                    
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                   
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    print(err)
                }
            }
        }
    }
    
    
    // получение списка тарифных планов
    // готово, работает
    func getPaymentList() {
      
        print("get Payment List called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.getPaymentList() { [self] result in
                print("get Payment List response: \(result)")
               
                switch result {
                case .success(let paymentList):
                    print(paymentList)
                    self.paymentList = paymentList
                    print("Success")
                case .serverError(let err):
                    
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                   
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    print(err)
                }
            }
        }
    }

    /*
    func getDevelopers() {
        withAnimation {
            devsProgress = .loading
        }
        print("get devs called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.getDevelopers() { [self] result in
                print("get devs response: \(result)")
                withAnimation {
                    registerPending = false
                }
                switch result {
                case .success(let devs):
                    withAnimation {
                        developers = devs
                        devsProgress = .finished
                    }
                case .serverError(let err):
                    withAnimation {
                        devsProgress = .error
                    }
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    withAnimation {
                        devsProgress = .error
                    }
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    withAnimation {
                        self.showAuthContainer = true
                    }
                }
            }
        }
    }
    */
}
