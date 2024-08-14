//
//  NetworkClient.swift
//  SwiftUI-MVVM-C
//
//  Created by Harshit Vaish on 11/08/24.
//

import Foundation
import Combine



class NetworkClient: NetworkProvider {
    
    static let instance = NetworkClient()

    
    private let session: URLSession
    
    private init() {
        session = URLSession.shared
    }
    
    func request(_ info:  RequestInfoConvertible) -> AnyPublisher<Data,  Error> {
        guard let requestInfo = info.asRequestInfo() else {
            return Fail(error: NetworkError.invalidRequestInfo).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: requestInfo)
            .tryMap { (data: Data, response: URLResponse) in
                if let response = response as? HTTPURLResponse {
                    debugPrint(response.statusCode)
                    switch response.statusCode {
                    case 200..<300:
                        return data
                    default:
                        throw NetworkError.somethingWentWrong(msg: HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
                    }
                } else {
                    throw NetworkError.somethingWentWrong(msg: "Invalid response")
                }
            }
            .eraseToAnyPublisher()
    }
}
