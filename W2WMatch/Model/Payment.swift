//
//  Payment.swift
//  W2WMatch
//
//  Created by Floron on 03.09.2024.
//

import Foundation

// MARK: - PaymentListElement
struct PaymentListElement: Codable, Identifiable {
    var id: Int
    var name: String
    var cost: Int
    var duration: String
}
