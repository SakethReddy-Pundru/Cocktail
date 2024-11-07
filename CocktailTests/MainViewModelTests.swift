//
//  MainViewModelTests.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 06/11/24.
//

@testable import Cocktail
import Combine
import XCTest

final class MainViewModelTests: XCTestCase {
    
    var viewModel = MainViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
        cancellables = []
        UserDefaults.standard.removeObject(forKey: "favorites")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSelectedCategory_DefaultValue() {
        XCTAssertEqual(viewModel.selectedCategory, "All", "The default selected category should be 'All'")
    }
    
    func testFilterCocktails_AllCategory() {
        // Given
        viewModel.cocktails = [
            CocktailDataModel(id: "0", name: "Piña colada", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 7, imageName: "pinacolada", ingredients: [
                "4 oz rum",
                "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
                "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
                "1 ounce freshly squeezed lime juice (optional)",
                "2 cups ice",
                "Fresh pineapple, for garnish"
            ]),
            CocktailDataModel(id: "1", name: "Mojito", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.", longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.", preparationMinutes: 10, imageName: "mojito", ingredients: [
                "10 fresh mint leaves",
                "½ lime, cut into 4 wedges",
                "2 tablespoons white sugar, or to taste",
                "1 cup ice cubes",
                "1 ½ fluid ounces white rum",
                "½ cup club soda"
            ])
        ]
        
        // When
        viewModel.selectedCategory = "All"
        
        // Then
        XCTAssertEqual(viewModel.filteredCocktails.count, 2, "Filtered cocktails should include all items when category is 'All'")
    }
    
    func testFilterCocktails_SpecificCategory() {
        // Given
        viewModel.cocktails = [
            CocktailDataModel(id: "0", name: "Piña colada", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 7, imageName: "pinacolada", ingredients: [
                "4 oz rum",
                "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
                "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
                "1 ounce freshly squeezed lime juice (optional)",
                "2 cups ice",
                "Fresh pineapple, for garnish"
            ]),
            CocktailDataModel(id: "1", name: "Mojito", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.", longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.", preparationMinutes: 10, imageName: "mojito", ingredients: [
                "10 fresh mint leaves",
                "½ lime, cut into 4 wedges",
                "2 tablespoons white sugar, or to taste",
                "1 cup ice cubes",
                "1 ½ fluid ounces white rum",
                "½ cup club soda"
            ])
        ]
        
        // When
        viewModel.selectedCategory = "alcoholic"
        
        // Then
        XCTAssertEqual(viewModel.filteredCocktails.count, 2, "Filtered cocktails should include only items matching the selected category")
        XCTAssertEqual(viewModel.filteredCocktails.first?.name, "Mojito", "The filtered cocktail should be Mojito")
    }
    
    func testLoadCocktailsFromJSON_FileNotFound() {
        // Given
        let mockBundle = Bundle(for: type(of: self))
        
        // Override the main bundle for testing if necessary, or mock load behavior
        viewModel.loadCocktailsFromJSON()
    }
    
    func testNavigationTitle_AllCategory() {
        viewModel.selectedCategory = "All"
        XCTAssertEqual(viewModel.navigationTitle, "All Cocktails", "The navigation title should be 'All Cocktails' when the category is 'All'")
    }
    
    func testNavigationTitle_SpecificCategory() {
        viewModel.selectedCategory = "Mocktails"
        XCTAssertEqual(viewModel.navigationTitle, "Mocktails", "The navigation title should be 'Mocktails' when the category is 'Mocktails'")
    }
    
    func testToggleFavorite_AddFavorite() {
        let cocktail = CocktailDataModel(id: "0", name: "Piña colada", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 7, imageName: "pinacolada", ingredients: [
            "4 oz rum",
            "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
            "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
            "1 ounce freshly squeezed lime juice (optional)",
            "2 cups ice",
            "Fresh pineapple, for garnish"
        ])
        viewModel.toggleFavorite(cocktail: cocktail)
        
        let savedFavorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        XCTAssertTrue(savedFavorites.contains("0"), "The cocktail should be added to favorites")
    }
    
    func testFilterCocktails_SortingWithFavorites() {
        // Given
        UserDefaults.standard.set(["1"], forKey: "favorites")
        viewModel.cocktails = [
            CocktailDataModel(id: "0", name: "Piña colada", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 7, imageName: "pinacolada", ingredients: [
                "4 oz rum",
                "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
                "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
                "1 ounce freshly squeezed lime juice (optional)",
                "2 cups ice",
                "Fresh pineapple, for garnish"
            ]),
            CocktailDataModel(id: "1", name: "Mojito", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.", longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.", preparationMinutes: 10, imageName: "mojito", ingredients: [
                "10 fresh mint leaves",
                "½ lime, cut into 4 wedges",
                "2 tablespoons white sugar, or to taste",
                "1 cup ice cubes",
                "1 ½ fluid ounces white rum",
                "½ cup club soda"
            ])
        ]
        
        // When
        viewModel.selectedCategory = "All"
        
        // Then
        XCTAssertEqual(viewModel.filteredCocktails.first?.id, "1", "The favorite cocktail should appear at the top of the list")
    }
    
    func testToggleFavorite_RemoveFavorite() {
        let cocktail = CocktailDataModel(id: "0", name: "Piña colada", type: TypeEnum(rawValue: "alcoholic")!, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 7, imageName: "pinacolada", ingredients: [
            "4 oz rum",
            "3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)",
            "2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)",
            "1 ounce freshly squeezed lime juice (optional)",
            "2 cups ice",
            "Fresh pineapple, for garnish"
        ])
        
        // First add to favorites
        viewModel.toggleFavorite(cocktail: cocktail)
        
        // Then remove from favorites
        viewModel.toggleFavorite(cocktail: cocktail)
        
        let savedFavorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        XCTAssertFalse(savedFavorites.contains("0"), "The cocktail should be removed from favorites")
    }
    
    func testFavoritesGetter() {
        UserDefaults.standard.set(["0"], forKey: "favorites")
        
        let favorites = viewModel.favorites
        XCTAssertTrue(favorites.contains("0"), "Favorites should contain the previously saved favorite item")
    }
    
    func testFavoritesSetter() {
        var favorites = viewModel.favorites
        favorites.insert("1")
        viewModel.favorites = favorites
        
        let savedFavorites = UserDefaults.standard.array(forKey: "favorites") as? [String] ?? []
        XCTAssertTrue(savedFavorites.contains("1"), "Favorites should be saved correctly to UserDefaults")
    }
}
