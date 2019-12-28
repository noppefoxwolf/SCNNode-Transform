//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2019/12/25.
//

import SceneKit

public protocol UniCompatible {
    associatedtype CompatibleType
    
    var uni: CompatibleType { get }
}

public final class Uni<Base> {
    let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension UniCompatible {
    var uni: Uni<Self> {
        return Uni(self)
    }
}

extension SCNNode: UniCompatible {}
