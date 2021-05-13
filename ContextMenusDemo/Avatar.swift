//
//  Avatar.swift
//  ContextMenusDemo
//
//  Created by Ben Scheirman on 4/7/21.
//

import Foundation
import Combine

struct Avatar: Decodable {
    let name: String
    let url: URL
}

let avatarsURL = URL(string: "https://gist.githubusercontent.com/subdigital/fed06496573dbb4cc24c2a3a8125c0fb/raw/413d600b243c2e7467869b29ac554fb2e32e65e9/avatars.json")!

extension Avatar {
    static func fetch() -> AnyPublisher<[Avatar], Error> {
        struct Wrapper: Decodable {
            let avatars: [Avatar]
        }
        return URLSession.shared.dataTaskPublisher(for: avatarsURL)
            .map { $0.data }
            .decode(type: Wrapper.self, decoder: JSONDecoder())
            .map { $0.avatars }
            .eraseToAnyPublisher()
    }
}
