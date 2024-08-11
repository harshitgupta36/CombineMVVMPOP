//
//  NetworkProvider.swift
//  SwiftUI-MVVM-C
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation

//import Alamofire
import Combine

protocol NetworkProvider {
    func request(_ info: RequestInfoConvertible) -> AnyPublisher<Data, Error>
}

extension URLRequest {
    
}

protocol RequestInfoConvertible {
    func asRequestInfo() -> URLRequest?
}
