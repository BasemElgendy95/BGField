//
//  BGConfigurable.swift
//  field
//
//  Created by Basem's Dawarha Macbook on 10/02/2025.
//

import Foundation

public protocol Configurable {}

extension Configurable {
    func changing<T>(path: WritableKeyPath<Self, T>, to value: T) -> Self {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
}
