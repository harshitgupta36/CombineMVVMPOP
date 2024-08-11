//
//  SafeCodable.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation

// MARK: - SafeDecodable Property Wrapper
@propertyWrapper
struct SafeCodable<T: Codable>: Codable {
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder)  throws {
        let container =  try decoder.singleValueContainer()
        wrappedValue = try? container.decode(T.self)
    }
}

extension KeyedDecodingContainer {
    func decode<T: Decodable>(_ type: SafeCodable<T>.Type, forKey key: Key) -> SafeCodable<T> {
        do {
        if let value = try decodeIfPresent(type, forKey: key) {
            return value
        }else{
            debugPrint("parsing error",type,key)
            return SafeCodable(wrappedValue: nil)
        }
        }catch{
            debugPrint("error we have ",error)
            return SafeCodable(wrappedValue: nil)
        }
    }
}
