//
//  Recipe.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import Foundation

struct SearchResult: Codable {
    var from: Int?
    var to: Int?
    var count: Int?
    var _links: Links?
    var hits: [Hit?]?
}

struct RecipeLink: Codable {
    var title: String?
    var href: String?
}

struct Links: Codable {
    var next: RecipeLink?
}

struct Hit: Codable {
    var recipe: Recipe?
    var _links: Links?
}

struct Recipe: Codable {
    var uri: String?
    var label: String?
    var image: String?
    var images: Images?
    var source: String?
    var url: String?
    var shareAs: String?
    var yield: Double?
    var dietLabels: [String?]?
    var healthLabels: [String?]?
    var cautions: [String?]
    var ingredientLines: [String?]?
    var ingredients: [Ingredient?]?
    var calories: Double?
    var totalCO2Emissions: Double?
    var co2EmissionsClass: String?
    var totalWeight: Double?
    var totalTime: Double?
    var cuisineType: [String?]?
    var mealType: [String?]?
    var dishType: [String?]?
    var totalNutrients: TotalNutrients?
    var digest: [Digest?]?
}

struct Images: Codable {
    var thumbnail: ImageDetail?
    var small: ImageDetail?
    var regular: ImageDetail?
    var large: ImageDetail?
}

struct ImageDetail: Codable {
    var url: String?
    var width: Int?
    var height: Int?
}

struct Ingredient: Codable {
    var text: String?
    var quantity: Double?
    var measure: String?
    var food: String?
    var weight: Double?
    var foodCategory: String?
    var foodId: String?
    var image: String?
}

struct TotalNutrients: Codable {
    var enercKcal: NutrientDetail?
    var fat: NutrientDetail?
    var fasat: NutrientDetail?
    var fatrn: NutrientDetail?
    var totalDaily: DailyNutrientDetail?
}

struct NutrientDetail: Codable {
    var label: String?
    var quantity: Double?
    var unit: String?
}

struct DailyNutrientDetail: Codable {
    var enercKcal: NutrientDetail?
    var fat: NutrientDetail?
    var fasat: NutrientDetail?
}

struct Digest: Codable {
    var label: String?
    var tag: String?
    var schemaOrgTag: String?
    var total: Double?
    var hasRDI: Bool?
    var daily: Double?
    var unit: String
}

