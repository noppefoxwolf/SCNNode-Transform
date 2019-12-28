//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2019/12/25.
//

import SceneKit

extension SCNQuaternion {
    static var identity: SCNQuaternion {
        SCNQuaternion(x: 0, y: 0, z: 0, w: 1)
    }
}

extension SCNQuaternion {
    init(from: SCNVector3, to: SCNVector3) {
        fatalError()
    }
    
    static func euler(_ value: SCNVector3) -> SCNQuaternion {
        fatalError()
    }
    
    static func euler(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNQuaternion {
        self.euler(SCNVector3(x, y, z))
    }
    
    static func lookRotation(_ value: SCNVector3) -> SCNQuaternion {
        fatalError()
    }
    
    static func inverse(_ value: SCNQuaternion) -> SCNQuaternion {
        fatalError()
    }
    
    static func angleAxis(_ angle: SCNFloat, axis: SCNVector3) -> SCNQuaternion {
        fatalError()
    }
}

extension Uni where Base == SCNQuaternion {
    /// Returns the euler angle representation of the rotation.
    var eulerAngles: SCNVector3 {
        fatalError()
    }
}


let SCNQuaternionIdentity: SCNQuaternion = SCNQuaternion(x: 0, y: 0, z: 0, w: 1)


/*
 x, y, and z represent the imaginary values.
 */
@inlinable func SCNQuaternionMake(_ x: SCNFloat, _ y: SCNFloat, _ z: SCNFloat, _ w: SCNFloat) -> SCNQuaternion {
    SCNQuaternion(x, y, z, w)
}

/*
 vector represents the imaginary values.
 */
@inlinable func SCNQuaternionMakeWithVector3(_ vector: SCNVector3, _ scalar: SCNFloat) -> SCNQuaternion {
    SCNQuaternion(x: vector.x, y: vector.y, z: vector.z, w: scalar)
}

/*
 values[0], values[1], and values[2] represent the imaginary values.
 */
@inlinable func SCNQuaternionMakeWithArray(_ values: [SCNFloat]) -> SCNQuaternion {
    guard values.count == 4 else { preconditionFailure() }
    return SCNQuaternion(x: values[0], y: values[1], z: values[2], w: values[3])
}

/*
 Assumes the axis is already normalized.
 */
@inlinable func SCNQuaternionMakeWithAngleAndAxis(_ radians: SCNFloat, _ x: SCNFloat, _ y: SCNFloat, _ z: SCNFloat) -> SCNQuaternion {
    let halfAngle: SCNFloat = radians * 0.5
    let scale: SCNFloat = SCNFloat(sinf(Float(halfAngle)))
    let q = SCNQuaternion(x: scale * x, y: scale * y, z: scale * z, w: CGFloat(cosf(Float(halfAngle))))
    return q
}

/*
 Assumes the axis is already normalized.
 */
@inlinable func SCNQuaternionMakeWithAngleAndVector3Axis(_ radians: SCNFloat, _ axisVector: SCNVector3) -> SCNQuaternion {
    SCNQuaternionMakeWithAngleAndAxis(radians, axisVector.x, axisVector.y, axisVector.z)
}

//func SCNQuaternionMakeWithMatrix3(_ matrix: SCNMatrix3) -> SCNQuaternion {
//    fatalError()
//}

func SCNQuaternionMakeWithMatrix4(_ matrix: SCNMatrix4) -> SCNQuaternion {
    fatalError()
}

/*
 Calculate and return the angle component of the angle and axis form.
 */
func SCNQuaternionAngle(_ quaternion: SCNQuaternion) -> SCNFloat {
    fatalError()
}

/*
 Calculate and return the axis component of the angle and axis form.
 */
func SCNQuaternionAxis(_ quaternion: SCNQuaternion) -> SCNVector3 {
    fatalError()
}

@inlinable func SCNQuaternionAdd(_ quaternionLeft: SCNQuaternion, _ quaternionRight: SCNQuaternion) -> SCNQuaternion {
    SCNQuaternion(quaternionLeft.x + quaternionRight.x,
                  quaternionLeft.y + quaternionRight.y,
                  quaternionLeft.z + quaternionRight.z,
                  quaternionLeft.w + quaternionRight.w)
}

@inlinable func SCNQuaternionSubtract(_ quaternionLeft: SCNQuaternion, _ quaternionRight: SCNQuaternion) -> SCNQuaternion {
    SCNQuaternion(quaternionLeft.x - quaternionRight.x,
                  quaternionLeft.y - quaternionRight.y,
                  quaternionLeft.z - quaternionRight.z,
                  quaternionLeft.w - quaternionRight.w)
}

@inlinable func SCNQuaternionMultiply(_ quaternionLeft: SCNQuaternion, _ quaternionRight: SCNQuaternion) -> SCNQuaternion {
    SCNQuaternion(
        quaternionLeft.w * quaternionRight.x +
        quaternionLeft.x * quaternionRight.w +
        quaternionLeft.y * quaternionRight.z -
        quaternionLeft.z * quaternionRight.y,
        
        quaternionLeft.w * quaternionRight.y +
        quaternionLeft.y * quaternionRight.w +
        quaternionLeft.z * quaternionRight.x -
        quaternionLeft.x * quaternionRight.z,
    
        quaternionLeft.w * quaternionRight.z +
        quaternionLeft.z * quaternionRight.w +
        quaternionLeft.x * quaternionRight.y -
        quaternionLeft.y * quaternionRight.x,
    
        quaternionLeft.w * quaternionRight.w -
        quaternionLeft.x * quaternionRight.x -
        quaternionLeft.y * quaternionRight.y -
        quaternionLeft.z * quaternionRight.z
    )
}

func SCNQuaternionSlerp(_ quaternionStart: SCNQuaternion, _ quaternionEnd: SCNQuaternion, _ t: SCNFloat) -> SCNQuaternion {
    fatalError()
}

@inlinable func SCNQuaternionLength(_ quaternion: SCNQuaternion) -> SCNFloat {
    sqrt(
        quaternion.x * quaternion.x +
        quaternion.y * quaternion.y +
        quaternion.z * quaternion.z +
        quaternion.w * quaternion.w
    )
}

@inlinable func SCNQuaternionConjugate(_ quaternion: SCNQuaternion) -> SCNQuaternion {
    SCNQuaternion(-quaternion.x, -quaternion.y, -quaternion.z, quaternion.w)
}

@inlinable func SCNQuaternionInvert(_ quaternion: SCNQuaternion) -> SCNQuaternion {
    let scale: SCNFloat = 1.0 / (
        quaternion.x * quaternion.x +
        quaternion.y * quaternion.y +
        quaternion.z * quaternion.z +
        quaternion.w * quaternion.w
    )
    return SCNQuaternion(-quaternion.x * scale, -quaternion.y * scale, -quaternion.z * scale, quaternion.w * scale)
}

@inlinable func SCNQuaternionNormalize(_ quaternion: SCNQuaternion) -> SCNQuaternion {
    let scale = 1.0 / SCNQuaternionLength(quaternion)
    return SCNQuaternion(quaternion.x * scale, quaternion.y * scale, quaternion.z * scale, quaternion.w * scale)
}

@inlinable func SCNQuaternionRotateVector3(_ quaternion: SCNQuaternion, _ vector: SCNVector3) -> SCNVector3 {
    var rotatedQuaternion: SCNQuaternion = SCNQuaternionMake(vector.x, vector.y, vector.z, 0.0)
    rotatedQuaternion = SCNQuaternionMultiply(SCNQuaternionMultiply(quaternion, rotatedQuaternion), SCNQuaternionInvert(quaternion))
    return SCNVector3Make(rotatedQuaternion.x, rotatedQuaternion.y, rotatedQuaternion.z)
}

/*
 The fourth component of the vector is ignored when calculating the rotation.
 */
@inlinable func SCNQuaternionRotateVector4(_ quaternion: SCNQuaternion, _ vector: SCNVector4) -> SCNVector4 {
    var rotatedQuaternion: SCNQuaternion = SCNQuaternionMake(vector.x, vector.y, vector.z, 0.0)
    rotatedQuaternion = SCNQuaternionMultiply(SCNQuaternionMultiply(quaternion, rotatedQuaternion), SCNQuaternionInvert(quaternion))
    return SCNVector4Make(rotatedQuaternion.x, rotatedQuaternion.y, rotatedQuaternion.z, vector.w)
}
