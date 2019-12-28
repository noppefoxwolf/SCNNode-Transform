//
//  SCNVector3+.swift
//  
//
//  Created by Tomoya Hirano on 2019/12/25.
//

import SceneKit

// https://docs.unity3d.com/jp/460/ScriptReference/Vector3.html
extension SCNVector3 {
    public static var back: SCNVector3 {
        SCNVector3(0, 0, -1)
    }
    
    public static var down: SCNVector3 {
        SCNVector3(0, -1, 0)
    }
    
    public static var forward: SCNVector3 {
        SCNVector3(0, 0, 1)
    }
    
    public static var left: SCNVector3 {
        SCNVector3(-1, 0, 0)
    }
    
    public static var one: SCNVector3 {
        SCNVector3(1, 1, 1)
    }
    
    public static var right: SCNVector3 {
        SCNVector3(1, 0, 0)
    }
    
    public static var up: SCNVector3 {
        SCNVector3(0, 1, 0)
    }
    
    public static var zero: SCNVector3 {
        SCNVector3(0, 0, 0)
    }
}


@inlinable func SCNVector3Make(_ x: SCNFloat, _ y: SCNFloat, _ z: SCNFloat) -> SCNVector3 {
    SCNVector3(x, y, z)
}

@inlinable func SCNVector3MakeWithArray(_ values: [SCNFloat]) -> SCNVector3 {
    guard values.count == 3 else { preconditionFailure() }
    return SCNVector3(values[0], values[1], values[2])
}

@inlinable func SCNVector3Negate(_ vector: SCNVector3) -> SCNVector3 {
    SCNVector3(-vector.x, -vector.y, -vector.z)
}

@inlinable func SCNVector3Add(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    SCNVector3(
        vectorLeft.x + vectorRight.x,
        vectorLeft.y + vectorRight.y,
        vectorLeft.z + vectorRight.z
    )
}

@inlinable func SCNVector3Subtract(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    SCNVector3(
        vectorLeft.x - vectorRight.x,
        vectorLeft.y - vectorRight.y,
        vectorLeft.z - vectorRight.z
    )
}

@inlinable func SCNVector3Multiply(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    SCNVector3(
        vectorLeft.x * vectorRight.x,
        vectorLeft.y * vectorRight.y,
        vectorLeft.z * vectorRight.z
    )
}

@inlinable func SCNVector3Divide(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    SCNVector3(
        vectorLeft.x / vectorRight.x,
        vectorLeft.y / vectorRight.y,
        vectorLeft.z / vectorRight.z
    )
}

@inlinable func SCNVector3AddScalar(_ vector: SCNVector3, _ value: SCNFloat) -> SCNVector3 {
    SCNVector3(
        vector.x + value,
        vector.y + value,
        vector.z + value
    )
}

@inlinable func SCNVector3SubtractScalar(_ vector: SCNVector3, _ value: SCNFloat) -> SCNVector3 {
    SCNVector3(
        vector.x - value,
        vector.y - value,
        vector.z - value
    )
}

@inlinable func SCNVector3MultiplyScalar(_ vector: SCNVector3, _ value: SCNFloat) -> SCNVector3 {
    SCNVector3(
        vector.x * value,
        vector.y * value,
        vector.z * value
    )
}

@inlinable func SCNVector3DivideScalar(_ vector: SCNVector3, _ value: SCNFloat) -> SCNVector3 {
    SCNVector3(
        vector.x / value,
        vector.y / value,
        vector.z / value
    )
}

/*
 Returns a vector whose elements are the larger of the corresponding elements of the vector arguments.
 */
@inlinable func SCNVector3Maximum(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    var max: SCNVector3 = vectorLeft
    if vectorRight.x > vectorLeft.x {
        max.x = vectorRight.x
    }
    if vectorRight.y > vectorLeft.y {
        max.y = vectorRight.y
    }
    if vectorRight.z > vectorLeft.z {
        max.z = vectorRight.z
    }
    return max
}

/*
 Returns a vector whose elements are the smaller of the corresponding elements of the vector arguments.
 */
@inlinable func SCNVector3Minimum(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    var min: SCNVector3 = vectorLeft
    if vectorRight.x < vectorLeft.x {
        min.x = vectorRight.x
    }
    if vectorRight.y < vectorLeft.y {
        min.y = vectorRight.y
    }
    if vectorRight.z < vectorLeft.z {
        min.z = vectorRight.z
    }
    return min
}


/*
 Returns true if all of the first vector's elements are equal to all of the second vector's arguments.
 */
@inlinable func SCNVector3AllEqualToVector3(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> Bool {
    var compare: Bool = false
    if vectorLeft.x == vectorRight.x &&
        vectorLeft.y == vectorRight.y &&
        vectorLeft.z == vectorRight.z {
        compare = true
    }
    return compare
}

/*
 Returns true if all of the vector's elements are equal to the provided value.
 */
@inlinable func SCNVector3AllEqualToScalar(_ vector: SCNVector3, _ value: SCNFloat) -> Bool {
    var compare: Bool = false
    if vector.x == value &&
        vector.y == value &&
        vector.z == value {
        compare = true
    }
    return compare
}

/*
 Returns true if all of the first vector's elements are greater than all of the second vector's arguments.
 */
@inlinable func SCNVector3AllGreaterThanVector3(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> Bool {
    var compare: Bool = false
    if vectorLeft.x > vectorRight.x &&
        vectorLeft.y > vectorRight.y &&
        vectorLeft.z > vectorRight.z {
        compare = true
    }
    return compare
}

/*
 Returns true if all of the vector's elements are greater than the provided value.
 */
@inlinable func SCNVector3AllGreaterThanScalar(_ vector: SCNVector3, _ value: SCNFloat) -> Bool {
    var compare: Bool = false
    if vector.x > value &&
        vector.y > value &&
        vector.z > value {
        compare = true
    }
    return compare
}

/*
 Returns true if all of the first vector's elements are greater than or equal to all of the second vector's arguments.
 */
@inlinable func SCNVector3AllGreaterThanOrEqualToVector3(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> Bool {
    var compare: Bool = false
    if vectorLeft.x >= vectorRight.x &&
        vectorLeft.y >= vectorRight.y &&
        vectorLeft.z >= vectorRight.z {
        compare = true
    }
    return compare
}

/*
 Returns true if all of the vector's elements are greater than or equal to the provided value.
 */
@inlinable func SCNVector3AllGreaterThanOrEqualToScalar(_ vector: SCNVector3, _ value: SCNFloat) -> Bool {
    var compare: Bool = false
    if vector.x >= value &&
        vector.y >= value &&
        vector.z >= value {
        compare = true
    }
    return compare
}

@inlinable func SCNVector3Normalize(_ vector: SCNVector3) -> SCNVector3 {
    let scale: SCNFloat = 1.0 / SCNVector3Length(vector)
    let v: SCNVector3 = SCNVector3(vector.x * scale, vector.y * scale, vector.z * scale)
    return v
}

@inlinable func SCNVector3DotProduct(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNFloat {
    vectorLeft.x * vectorRight.x + vectorLeft.y * vectorRight.y + vectorLeft.z * vectorRight.z
}

@inlinable func SCNVector3Length(_ vector: SCNVector3) -> SCNFloat {
    sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z)
}

// Convenience
@inlinable func SCNVector3LengthSquared(_ vector: SCNVector3) -> SCNFloat {
    vector.x * vector.x + vector.y * vector.y + vector.z * vector.z
}

@inlinable func SCNVector3Distance(_ vectorStart: SCNVector3, _ vectorEnd: SCNVector3) -> SCNFloat {
    SCNVector3Length(SCNVector3Subtract(vectorEnd, vectorStart))
}

@inlinable func SCNVector3Lerp(_ vectorStart: SCNVector3, _ vectorEnd: SCNVector3, _ t: SCNFloat) -> SCNVector3 {
    SCNVector3(
        vectorStart.x + ((vectorEnd.x - vectorStart.x) * t),
        vectorStart.y + ((vectorEnd.y - vectorStart.y) * t),
        vectorStart.z + ((vectorEnd.z - vectorStart.z) * t)
    )
}

@inlinable func SCNVector3CrossProduct(_ vectorLeft: SCNVector3, _ vectorRight: SCNVector3) -> SCNVector3 {
    SCNVector3(
        vectorLeft.y * vectorRight.z - vectorLeft.z * vectorRight.y,
        vectorLeft.z * vectorRight.x - vectorLeft.x * vectorRight.z,
        vectorLeft.x * vectorRight.y - vectorLeft.y * vectorRight.x
    )
}

/*
 Project the vector, vectorToProject, onto the vector, projectionVector.
 */
@inlinable func SCNVector3Project(_ vectorToProject: SCNVector3, _ projectionVector: SCNVector3) -> SCNVector3 {
    let scale: SCNFloat = SCNVector3DotProduct(projectionVector, vectorToProject) / SCNVector3DotProduct(projectionVector, projectionVector)
    let v: SCNVector3 = SCNVector3MultiplyScalar(projectionVector, scale)
    return v
}
