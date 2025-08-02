//
//  Router.swift
//  SCMP_Assignment
//
//  Created by James on 2/8/2025.
//

import Combine

enum Route: Hashable {
    case login
    case staffList
}


class Router: ObservableObject {
    @Published var path: [Route] = []
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
