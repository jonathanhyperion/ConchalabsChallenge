//
//  Descriptable.swift
//  CodeChallenge
//
//  Created by Dev on 7/3/22.
//

protocol Descriptable {

    var description: String { get }

}

protocol ErrorDescriptable: Descriptable { }
