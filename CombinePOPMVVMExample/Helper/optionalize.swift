//
//  optionalize.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//

import Combine

extension Publisher {
    func optionalize() -> AnyPublisher<Self.Output?, Self.Failure> {
        return self.map { $0 }.eraseToAnyPublisher()
    }
}
