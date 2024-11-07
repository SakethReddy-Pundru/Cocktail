//
//  CoordinatorView.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

import Foundation
import SwiftUI

//  CoordinatorView, this will be a SwiftUI view that will be set as the entry point of the application. This view will connect the Coordinator class logic with NavigationStack, .fullScreenCover and .sheet APIs. CoordinatorView will also set the root view for the NavigationStack.
//    Inject the Coordinator in the NavigationStack as an @EnvironmentObject and use the coordinator in any View under the Stack to handle navigation.
                                                                                                                                                                            
struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .main)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
