//
//  CocktailDataModel.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 06/11/24.
//

import Foundation

// MARK: - Cocktail Data Model

/// A struct that represents the data model for a cocktail.
struct CocktailDataModel: Codable, Identifiable, Equatable, Hashable {
    
    // MARK: Properties
    let id, name: String
    let type: TypeEnum
    let shortDescription, longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    
    // MARK: Equatable Conformance
    
    /// Compares two CocktailDataModel instances for equality.
    static func == (lhs: CocktailDataModel, rhs: CocktailDataModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.shortDescription == rhs.shortDescription &&
        lhs.longDescription == rhs.longDescription &&
        lhs.preparationMinutes == rhs.preparationMinutes &&
        lhs.imageName == rhs.imageName &&
        lhs.ingredients == rhs.ingredients
    }
}

// MARK: - Cocktail Type Enum

/// An enum that represents the type of the cocktail, either alcoholic or non-alcoholic.
enum TypeEnum: String, Codable {
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}
