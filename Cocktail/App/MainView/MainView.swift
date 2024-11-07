//
//  MainView.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

// MARK: - Main View

import SwiftUI

/// The main view for displaying cocktails with filtering options.
struct MainView: View {
    
    // MARK: Properties
    
    /// The view model that manages the state and business logic for the main view.
    @ObservedObject var viewModel = MainViewModel()
    
    /// The environment object for navigation coordination.
    @EnvironmentObject private var coordinator: Coordinator
    
    let options = ["All", "Alcoholic", "Non-Alcoholic"]
    
    // MARK: Body
    
    var body: some View {
        VStack() {
            SegmentControl(options: options, selectedOption: $viewModel.selectedCategory)
            
            // List of filtered cocktails
            List(viewModel.filteredCocktails) { cocktail in
                Button(action: {
                    coordinator.push(page: .detail(cocktail: cocktail, category: viewModel.navigationTitle))
                }) {
                    VStack(alignment: .leading) {
                        HStack {
                            
                            // Display cocktail name
                            Text(cocktail.name)
                                .font(.headline)
                                .foregroundStyle(viewModel.favorites.contains(cocktail.id) ? .moderateViolet : .primary)
                            
                            Spacer()
                            
                            // Show favorite indicator if the cocktail is in favorites
                            if viewModel.favorites.contains(cocktail.id) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.moderateViolet)
                            }
                        }
                        
                        // Display short description of the cocktail
                        Text(cocktail.shortDescription)
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

#Preview {
    MainView()
}
