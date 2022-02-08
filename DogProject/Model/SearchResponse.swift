//
//  SearchResponse.swift
//  DogProject
//
//  Created by Роман Зобнин on 31.10.2021.
//

import Foundation

struct Breeds: Decodable {
    let message: [String: [String]]
   
    var breedNamesList: [String] {
        return message.keys.map({$0})
    }
}

struct BreedsImage: Decodable {
    let message: [String]
}


