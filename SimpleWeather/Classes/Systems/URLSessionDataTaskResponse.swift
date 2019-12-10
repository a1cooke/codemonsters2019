//
//  URLSessionDataTaskResponseHandler.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum FetchError {
    case json(String)
    case jsonCast
    case parsing
    case emptyResponse
    case network(String)
}

func ==(lhs: FetchError, rhs: FetchError) -> Bool {
    switch (lhs, rhs) {
    case let (.json(value1), .json(value2)) where value1 == value2: return true
    case (.jsonCast, .jsonCast): return true
    case (.parsing, .parsing): return true
    case (.emptyResponse, .emptyResponse): return true
    case let (.network(value1), .network(value2)) where value1 == value2: return true
    default: return false
    }
}

enum URLSessionResult<T: Decodable> {
    case success(T)
    case failure(FetchError)
}

struct URLSessionDataTaskResponse<T: Decodable> {

    // serialize Data into [AnyHashable: Any] via JSONSerialization
    let serializeJSON: Bool

    // take the result of deserialize and do some processing on it
    let parse: (Data) -> T?

    func handle(data: Data?, error: Error?) -> URLSessionResult<T> {
        guard let data = data else {
            if let error = error {
                return .failure(.network(error.localizedDescription))
            } else {
                return .failure(.emptyResponse)
            }
        }

        if let parsedObject = parse(data) {
            return .success(parsedObject)
        }
        
        return .failure(.parsing)
    }

}
