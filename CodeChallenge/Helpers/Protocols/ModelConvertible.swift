//
//  ModelConvertible.swift
//  CodeChallenge
//
//  Created by Dev on 8/3/22.
//

protocol ModelConvertible {

    associatedtype Model

    func asModel() -> Model

}
