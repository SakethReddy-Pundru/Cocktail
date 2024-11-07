//
//  Coordinator.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

import Foundation
import SwiftUI

//  Coordinator class that handles the navigation flow logic and decide, which View will be rendered when a navigation event is triggered.
//  ViewBuilder: A custom parameter attribute that constructs views from closures.

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .main:
            MainView()
                .navigationBarBackButtonHidden(true)
//                .navigationTitle("All Cocktails")
                .navigationBarTitleDisplayMode(.automatic)
        case .detail(let cocktail, let category):
            DetailView(cocktail: cocktail, category: category)
                .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
