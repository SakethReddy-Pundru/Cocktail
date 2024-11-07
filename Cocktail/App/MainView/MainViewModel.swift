//
//  MainViewModel.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

// MARK: - Main View Model

import Combine
import Foundation
import SwiftUICore

/// The view model responsible for managing the cocktail data and filtering logic.

class MainViewModel: ObservableObject {
    
    // MARK: Published Properties
    
    /// The currently selected category for filtering cocktails.
    @Published var selectedCategory: String = "All" {
        didSet {
            filterCocktails()
        }
    }
    
    /// The list of cocktails filtered based on the selected category.
    @Published var filteredCocktails: [CocktailDataModel] = []
    
    // MARK: Properties
    
    /// The complete list of cocktails loaded from the data source.
    var cocktails: [CocktailDataModel] = []
    var cancellables = Set<AnyCancellable>()
    
    // MARK: Initializer
    
    init() {
        loadCocktailsFromJSON()
        filterCocktails()
        
        $selectedCategory
            .sink { [weak self] _ in
                self?.filterCocktails()
            }
            .store(in: &cancellables)
    }
    
    // MARK: Filtering Logic
    
    /// Filters the cocktails based on the selected category and sorts them.
    func filterCocktails() {
        if selectedCategory == "All" {
            filteredCocktails = cocktails
        } else {
            filteredCocktails = cocktails.filter { $0.type.rawValue.lowercased() == selectedCategory.lowercased() }
        }
        filteredCocktails.sort {
            if favorites.contains($0.id) && !favorites.contains($1.id) {
                return true
            } else if !favorites.contains($0.id) && favorites.contains($1.id) {
                return false
            } else {
                return $0.name < $1.name
            }
        }
    }
    
    // MARK: Data Loading
    
    /// Loads cocktail data from a JSON file in the app bundle.
    func loadCocktailsFromJSON() {
        guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            print("Failed to locate cocktails.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedCocktails = try JSONDecoder().decode([CocktailDataModel].self, from: data)
            self.cocktails = decodedCocktails
            self.filteredCocktails = decodedCocktails
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }
    
    // MARK: Navigation Title
    
    /// Returns the title to be displayed in the navigation bar based on the selected category.
    var navigationTitle: String {
        return selectedCategory == "All" ? "All Cocktails" : selectedCategory
    }
    
    // MARK: Favorites Management
    
    /// Toggles the favorite status of a cocktail.
    func toggleFavorite(cocktail: CocktailDataModel) {
        var updatedFavorites = favorites
        if updatedFavorites.contains(cocktail.id) {
            updatedFavorites.remove(cocktail.id)
        } else {
            updatedFavorites.insert(cocktail.id)
        }
        favorites = updatedFavorites
    }
    
    /// A set of favorite cocktail IDs, managed through UserDefaults.
    var favorites: Set<String> {
        get {
            let savedFavorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
            return Set(savedFavorites)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: "favorites")
            objectWillChange.send()
        }
    }
}
