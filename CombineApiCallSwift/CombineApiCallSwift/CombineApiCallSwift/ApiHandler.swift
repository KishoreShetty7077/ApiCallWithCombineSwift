//
//  ApiHandler.swift
//  CombineApiCallSwift
//
//  Created by Kishore B on 8/19/24.
//

import Foundation
import Combine


enum NetworkError: Error {
    case badServerResponse
    case decodingError
}

class APIHandler {
    static let shared = APIHandler()
    private init() {}

    func fetchData<T: Decodable>(from urlString: String, decodeTo type: T.Type) -> AnyPublisher<T, Error> {
        // Convert the string to a URL object
        guard let url = URL(string: urlString) else {
            // Handle the case where the string could not be converted to a valid URL
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.badServerResponse
                }
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .retry(3)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}







//class APIHandler {
//    static let shared = APIHandler()
//    private init() {}
//
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetchData<T: Decodable>(from url: URL, decodeTo type: T.Type) -> AnyPublisher<T, Error> {
//        URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { data, response in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    throw NetworkError.badServerResponse
//                }
//                return data
//            }
//            .decode(type: type, decoder: JSONDecoder())
//            .retry(3)
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//}







/*
 
enum NetworkError: Error {
    case badServerResponse
}

    var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .retry(3)
            .receive(on: DispatchQueue.main)
//            .receive(on: RunLoop.main)  --> in SwiftUI
            .eraseToAnyPublisher()
    }

 */

