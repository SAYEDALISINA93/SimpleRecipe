//
//  APIList.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import Foundation

struct APIList {
    private static let baseURL = "https://api.edamam.com/api/recipes/v2?app_key=28a3948d4005c78725948cbf4348b2ea&type=public&app_id=62c9d30a"
    
    static var search: String {
        return baseURL + "&q="
    }
}
