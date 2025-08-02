//
//  StaffInfoResponse.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Foundation


// MARK: - StaffInfoPage
struct StaffInfoResponse: Codable, NetworkResponse {
    let page, perPage, total, totalPages: Int
    let data: [Staff]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
    
    
}

// MARK: - Staff
struct Staff: Codable, Identifiable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
