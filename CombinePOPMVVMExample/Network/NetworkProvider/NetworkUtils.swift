//
//  NetworkUtils.swift
//  SwiftUI-MVVM-C
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation
import Combine



extension AnyPublisher where Output == Data, Failure == Error {
    func jsonObject() -> AnyPublisher<[String: Any], Failure> {
        tryMap { data -> [String: Any] in
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return jsonObject
            }
            
            throw NetworkError.invalidJSON
        }.eraseToAnyPublisher()
    }
    
    func jsonObjects() -> AnyPublisher<[[String: Any]], Failure> {
        tryMap { data -> [[String: Any]] in
            if let jsonObjects = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                return jsonObjects
            }
            
            throw NetworkError.invalidJSON
        }.eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(jsonDecoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Failure> {
        tryMap { data -> T in
            return try jsonDecoder.decode(T.self, from: data)
        }.eraseToAnyPublisher()
    }
}
