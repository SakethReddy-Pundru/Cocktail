//
//  Screens.swift
//  Cocktail
//
//  Created by Saketh Reddy Pundru on 05/11/24.
//

import Foundation

//  Type of Views that will be used in the Navigation flow of the application.
//  enum that includes the type of Views created as it's cases.

enum AppPages: Hashable {
    case main
    case detail(cocktail: CocktailDataModel, category: String)
}
