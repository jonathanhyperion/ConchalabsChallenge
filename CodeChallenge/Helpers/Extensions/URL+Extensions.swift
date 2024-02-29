//
//  URL+Extensions.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

import Foundation

extension URL {

    func decodePropertyList<T: Decodable>() throws -> T {
        
        let data = try Data(contentsOf: self)
        
        let decoder = PropertyListDecoder()
        
        return try decoder.decode(T.self, from: data)
        
    }

}
