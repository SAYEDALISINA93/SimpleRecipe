//
//  Network.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func serverRequest<T: Decodable>(from url: String, method: HTTPMethod, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                    
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
