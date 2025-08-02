//
//  StaffPageData.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import SwiftData
import Foundation

@Model
final class StaffPageData {
    @Attribute(.unique) var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    @Attribute(.externalStorage) var data: [Staff]
    var support: Support

    init(page: Int, perPage: Int, total: Int, totalPages: Int, data: [Staff], support: Support) {
        self.page = page
        self.perPage = perPage
        self.total = total
        self.totalPages = totalPages
        self.data = data
        self.support = support
    }
}
