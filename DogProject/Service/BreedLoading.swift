//
//  BreedLoading.swift
//  DogProject
//
//  Created by Роман Зобнин on 31.10.2021.
//

import Foundation

protocol breedDelegate {
    func saveBreeds (nameBreed: [String])
}

protocol breedImageDelegate {
    func saveBreedsImage (string: [String])
}

class breedLoader{
    var delegate: breedDelegate?
    func request() {
        let urlString = "https://dog.ceo/api/breeds/list/all"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print ("data не пришла")
                return
            }
            guard error == nil else {
                print(error ?? "error")
                return}
            do {
                let message = try JSONDecoder().decode(Breeds.self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.saveBreeds(nameBreed: message.breedNamesList)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

class breedLoaderImage {
    var delegate: breedImageDelegate?
    func request(name: String) {
        let urlString = "https://dog.ceo/api/breed/"+name+"/images"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print ("data не пришла")
                return
            }
            guard error == nil else {
                print(error ?? "error")
                return}
            do {
                let message = try JSONDecoder().decode(BreedsImage.self, from: data).message
                DispatchQueue.main.async {
                    self.delegate?.saveBreedsImage(string: message)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
