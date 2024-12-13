//
//  ErrorsModel.swift
//  W2WMatch
//
//  Created by Floron on 08.06.2024.
//

import Foundation

extension String {
    var decoded : String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
}

struct ErrorsAnalyzer {
    private let errorsDictionary = ["password": "Пароль не должен быть пустым!",
                                    "email": "Email не должен быть пустым!",
                                    "phone": "Телефон не должен быть пустым!"]
    private let errorsArray = ["Это поле не может быть пустым.", "This field may not be blank."]
    
    func analyzeServerResponce (serverResponce: [String: Any]) -> String {
        var errorMessage = ""
        let kol = serverResponce.count
        var enteredTimes = 1
        for (key, error) in serverResponce {
            print("Key: \(key)      Error: \(error)")
            if let stringError = error as? [String] {
                for singleError in stringError {
                    if errorsArray.contains(singleError) {
                        if kol == enteredTimes {
                            errorMessage.append(errorsDictionary[key] ?? "")
                        } else {
                            errorMessage = errorMessage + "\(errorsDictionary[key] ?? "")\n\n"
                            enteredTimes += 1
                        }
                    } else {
                        if kol == enteredTimes {
                            errorMessage.append(singleError)
                        } else {
                            errorMessage = errorMessage + "\(singleError)\n\n"
                            enteredTimes += 1
                        }
                    }
                }
            }
            
            if let stringError = error as? String {
                errorMessage.append(stringError)
            }
        }
//        print("Error: ", errorMessage)
        
        return errorMessage
    }
}
