//
//  CreateBrand.swift
//  W2WMatch
//
//  Created by Floron on 20.06.2024.
//

import Foundation

// MARK: - CreateBrandRequestBody
struct CreateBrandRequestBody: Codable {
    var category = RequestQuestionType()
    var presenceType = RequestQuestionType()
    var publicSpeaker = RequestQuestionType()
    var subsCount = RequestQuestionType()
    var avgBill = RequestQuestionType()
    var goals = [RequestQuestionType()]
    var formats = [RequestQuestionType()]
    var collaborationInterest = [RequestQuestionType()]
    var tgNickname = ""              // done
    var brandNamePos = ""           // done
    var instBrandURL = ""           // done
    var brandSiteURL = ""           // done
    var topics = ""                 // done
    var missionStatement = ""       // done
    var targetAudience = ""      // check me on AboutYorselfScreen
    var uniqueProductIs = ""        // done
    var productDescription = ""     // done
    var problemSolving = ""         // done
    var businessGroup = ""          // done
    var logo = ""                   // 13
    var photo = ""                  // 14
    var productPhoto = ""           // 12 LastAuthScreen
    var fullname = ""               // done

    enum CodingKeys: String, CodingKey {
        case category
        case presenceType = "presence_type"
        case publicSpeaker = "public_speaker"
        case subsCount = "subs_count"
        case avgBill = "avg_bill"
        case goals, formats
        case collaborationInterest = "collaboration_interest"
        case tgNickname = "tg_nickname"
        case brandNamePos = "brand_name_pos"
        case instBrandURL = "inst_brand_url"
        case brandSiteURL = "brand_site_url"
        case topics
        case missionStatement = "mission_statement"
        case targetAudience = "target_audience"
        case uniqueProductIs = "unique_product_is"
        case productDescription = "product_description"
        case problemSolving = "problem_solving"
        case businessGroup = "business_group"
        case logo, photo
        case productPhoto = "product_photo"
        case fullname
    }
}

// MARK: - AvgBill
struct RequestQuestionType: Codable {
    var text: String = ""
    var question: Int = 0
}


// MARK: - CreateBrand response
struct CreateBrandResponse: Codable {
    var id: Int
    var user: User
    var subscription: Subscription?
    var category, presenceType, publicSpeaker, subsCount: AvgBill
    var avgBill: AvgBill
    var goals, formats, collaborationInterest: [AvgBill]
    var subExpire: String?
    var tgNickname, brandNamePos, instBrandURL: String
    var brandSiteURL, topics, missionStatement, targetAudience: String
    var uniqueProductIs, productDescription, problemSolving, businessGroup: String
    var logo, photo, productPhoto, fullname: String

    enum CodingKeys: String, CodingKey {
        case id, user, subscription, category
        case presenceType = "presence_type"
        case publicSpeaker = "public_speaker"
        case subsCount = "subs_count"
        case avgBill = "avg_bill"
        case goals, formats
        case collaborationInterest = "collaboration_interest"
        case subExpire = "sub_expire"
        case tgNickname = "tg_nickname"
        case brandNamePos = "brand_name_pos"
        case instBrandURL = "inst_brand_url"
        case brandSiteURL = "brand_site_url"
        case topics
        case missionStatement = "mission_statement"
        case targetAudience = "target_audience"
        case uniqueProductIs = "unique_product_is"
        case productDescription = "product_description"
        case problemSolving = "problem_solving"
        case businessGroup = "business_group"
        case logo, photo
        case productPhoto = "product_photo"
        case fullname
    }
}

// MARK: - AvgBill
struct AvgBill: Codable {
    var text: String
}

// MARK: - Subscription
struct Subscription: Codable {
    var id: Int
    var name: String
    var cost: Int
    var duration: String
}

// MARK: - User
struct User: Codable {
    var id: Int
    var email, phone: String
}

struct AboutClientInfo {
    var theme: String = ""
    var gender: String = ""
    var age: String = ""
    var incomeLevel: String = ""
    var geographic: String = ""
    var interests: String = ""
}
