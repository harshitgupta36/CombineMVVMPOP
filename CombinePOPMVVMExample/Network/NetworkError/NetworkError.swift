//
//  NetworkError.swift
//  CombinePOPMVVMExample
//
//  Created by Harshit Vaish on 11/08/24.
//


enum NetworkError: Error {
    case invalidResponse
    case invalidInput
    case invalidJSON
    case other(Error)
    case somethingWentWrong(msg: String)
    case invalidRequestInfo
}
