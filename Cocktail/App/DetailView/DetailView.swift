//
//  DetailView.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

// MARK: - Detail View

import SwiftUI

/// A view that displays detailed information about a cocktail.

struct DetailView: View {
    
    // MARK: Environment and State Properties
        
        /// The environment object for managing navigation coordination.
    @EnvironmentObject private var coordinator: Coordinator
    
    /// State variable indicating whether the cocktail is marked as favorite.
    @State private var isHeartFilled: Bool = false
    
    /// The view model for managing cocktail data and favorites.
    @ObservedObject var viewModel = MainViewModel()
    
    // MARK: Parameters
       
       /// The cocktail to display in detail.
    var cocktail: CocktailDataModel
    
    /// The category of the cocktail for navigation purposes.
    var category: String
    
    // MARK: Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                // Preparation time display
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.gray)
                    Text("\(String(cocktail.preparationMinutes)) minutes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                // Cocktail image display
                Image(cocktail.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.3))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Long description of the cocktail
                Text(cocktail.longDescription)
                    .font(.custom("Verdana", size: 14))
                    .lineSpacing(6.0)
                    .multilineTextAlignment(.leading)
                
                // Ingredients header
                Text("Ingredients")
                    .font(.headline)
                    .padding(.top)
                
                // List of ingredients
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "chevron.right.circle.fill")
                        Text(ingredient)
                    }
                    .font(.custom("Verdana", size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
        }
        .padding()
        
        .onAppear {
            // Check if the cocktail is in favorites when the view appears
            isHeartFilled = viewModel.favorites.contains(cocktail.id)
        }
        
        .navigationTitle(cocktail.name)
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            // Back button in the toolbar
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    coordinator.pop()
                }) {
                    Image(systemName: "chevron.left")
                    Text(category)
                }
            }
            
            // Favorite button in the toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(isHeartFilled ? Color.moderateViolet : .gray)
                    .onTapGesture {
                        isHeartFilled.toggle()
                        viewModel.toggleFavorite(cocktail: cocktail)
                    }
                    .padding()
            }
        }
    }
}
