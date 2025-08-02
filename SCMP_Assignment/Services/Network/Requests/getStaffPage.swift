//
//  getStaffPage.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Foundation


extension NetworkRequest where ResponseType == StaffInfoResponse {
    static func getStaffPage(num: Int) -> NetworkRequest<StaffInfoResponse> {
        let urlString = "https://reqres.in/api/users?page=\(num)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        return NetworkRequest<StaffInfoResponse>(
            method: .get,
            url: url,
            headers: [
                "x-api-key": "reqres-free-v1"
            ],
            body: nil,
            requestType: .json
        )
    }
}
