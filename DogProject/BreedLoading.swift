//
//  BreedLoading.swift
//  DogProject
//
//  Created by Роман Зобнин on 31.10.2021.
//

import Foundation

protocol breedDelegate {
    func saveBreeds (nameBreed: String)
}

class breedLoader {
    
    var delegate: breedDelegate?
    
    func request (urlString: String, completion: @escaping (Result<Response, Error>)->Void){
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print("Error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let breeds = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(breeds))
                } catch let jsonError {
                    print("failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

