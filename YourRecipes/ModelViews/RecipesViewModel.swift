//
//  RecipesViewModel.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import Foundation

import Foundation
import Combine

class RecipesViewModel {
    var searchResult: SearchResult?
    var isLoading = false
    var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchData(params: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        isLoading = true
        errorMessage = nil
        searchResult = nil

        let url = APIList.search + params

        APIManager.shared.serverRequest(from: url, model: SearchResult.self) { result in
            switch result {
            case .success(let data):
                self.isLoading = false
                self.searchResult = data
                completion(.success(data))
            case .failure(let error):
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                completion(.failure(error))
            }
        }
    }
}
