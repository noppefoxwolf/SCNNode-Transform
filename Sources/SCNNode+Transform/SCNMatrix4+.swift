//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2019/12/28.
//

import SceneKit

@inlinable func SCNMatrix4Make(m00: SCNFloat, m01: SCNFloat, m02: SCNFloat, m03: SCNFloat,
                               m10: SCNFloat, m11: SCNFloat, m12: SCNFloat, m13: SCNFloat,
                               m20: SCNFloat, m21: SCNFloat, m22: SCNFloat, m23: SCNFloat,
                               m30: SCNFloat, m31: SCNFloat, m32: SCNFloat, m33: SCNFloat) -> SCNMatrix4 {
    SCNMatrix4(
        m11: m00, m12: m01, m13: m02, m14: m03,
        m21: m10, m22: m11, m23: m12, m24: m13,
        m31: m20, m32: m21, m33: m22, m34: m23,
        m41: m30, m42: m31, m43: m32, m44: m33
    )
}

@inlinable func SCNMatrix4MakeAndTranspose(m00: SCNFloat, m01: SCNFloat, m02: SCNFloat, m03: SCNFloat,
                                           m10: SCNFloat, m11: SCNFloat, m12: SCNFloat, m13: SCNFloat,
                                           m20: SCNFloat, m21: SCNFloat, m22: SCNFloat, m23: SCNFloat,
                                           m30: SCNFloat, m31: SCNFloat, m32: SCNFloat, m33: SCNFloat) -> SCNMatrix4 {
    SCNMatrix4(
        m11: m00, m12: m10, m13: m20, m14: m30,
        m21: m01, m22: m11, m23: m21, m24: m31,
        m31: m02, m32: m12, m33: m22, m34: m32,
        m41: m03, m42: m13, m43: m23, m44: m33
    )
}
    
@inlinable func SCNMatrix4MakeWithArray(_ values: [SCNFloat]) -> SCNMatrix4 {
    guard values.count == 16 else { preconditionFailure() }
    return SCNMatrix4(
        m11: values[0],  m12: values[1],  m13: values[2],  m14: values[3],
        m21: values[4],  m22: values[5],  m23: values[6],  m24: values[7],
        m31: values[8],  m32: values[9],  m33: values[10], m34: values[11],
        m41: values[12], m42: values[13], m43: values[14], m44: values[15]
    )
}
 
@inlinable func SCNMatrix4MakeWithArrayAndTranspose(_ values: [SCNFloat]) -> SCNMatrix4 {
    guard values.count == 16 else { preconditionFailure() }
    return SCNMatrix4(
        m11: values[0], m12: values[4], m13: values[8],  m14: values[12],
        m21: values[1], m22: values[5], m23: values[9],  m24: values[13],
        m31: values[2], m32: values[6], m33: values[10], m34: values[14],
        m41: values[3], m42: values[7], m43: values[11], m44: values[15]
    )
}

@inlinable func SCNMatrix4MakeWithRows(_ row0: SCNVector4,
                                       _ row1: SCNVector4,
                                       _ row2: SCNVector4,
                                       _ row3: SCNVector4) -> SCNMatrix4 {
    SCNMatrix4(
        m11: row0.x, m12: row1.x, m13: row2.x, m14: row3.x,
        m21: row0.y, m22: row1.y, m23: row2.y, m24: row3.y,
        m31: row0.z, m32: row1.z, m33: row2.z, m34: row3.z,
        m41: row0.w, m42: row1.w, m43: row2.w, m44: row3.w
    )
}

@inlinable func SCNMatrix4MakeWithColumns(_ column0: SCNVector4,
                                          _ column1: SCNVector4,
                                          _ column2: SCNVector4,
                                          _ column3: SCNVector4) -> SCNMatrix4 {
    SCNMatrix4(
        m11: column0.x, m12: column0.y, m13: column0.z, m14: column0.w,
        m21: column1.x, m22: column1.y, m23: column1.z, m24: column1.w,
        m31: column2.x, m32: column2.y, m33: column2.z, m34: column2.w,
        m41: column3.x, m42: column3.y, m43: column3.z, m44: column3.w
    )
}
    
@inlinable func SCNMatrix4MakeWithQuaternion(_ quaternion: SCNQuaternion) -> SCNMatrix4 {
    let quaternion = SCNQuaternionNormalize(quaternion)
    
    let x: SCNFloat = quaternion.x
    let y: SCNFloat = quaternion.y
    let z: SCNFloat = quaternion.z
    let w: SCNFloat = quaternion.w
    
    let _2x: SCNFloat = x + x
    let _2y: SCNFloat = y + y
    let _2z: SCNFloat = z + z
    let _2w: SCNFloat = w + w
    
    let m = SCNMatrix4(
        m11: 1.0 - _2y * y - _2z * z,
        m12: _2x * y + _2w * z,
        m13: _2x * z - _2w * y,
        m14: 0.0,
        m21: _2x * y - _2w * z,
        m22: 1.0 - _2x * x - _2z * z,
        m23: _2y * z + _2w * x,
        m24: 0.0,
        m31: _2x * z + _2w * y,
        m32: _2y * z - _2w * x,
        m33: 1.0 - _2x * x - _2y * y,
        m34: 0.0,
        m41: 0.0,
        m42: 0.0,
        m43: 0.0,
        m44: 1.0
    )
    return m
}
    
@inlinable func SCNMatrix4MakeTranslation(_ tx: SCNFloat, _ ty: SCNFloat, _ tz: SCNFloat) -> SCNMatrix4 {
    var m = SCNMatrix4Identity
    m.m41 = tx
    m.m42 = ty
    m.m43 = tz
    return m
}

@inlinable func SCNMatrix4MakeScale(_ sx: SCNFloat, _ sy: SCNFloat, _ sz: SCNFloat) -> SCNMatrix4 {
    var m = SCNMatrix4Identity
    m.m11 = sx
    m.m22 = sy
    m.m33 = sz
    return m
}

@inlinable func SCNMatrix4MakeRotation(_ radians: SCNFloat, _ x: SCNFloat, _ y: SCNFloat, _ z: SCNFloat) -> SCNMatrix4 {
    let v: SCNVector3 = SCNVector3Normalize(SCNVector3Make(x, y, z))
    let cos: SCNFloat = SCNFloat(cosf(Float(radians)))
    let cosp: SCNFloat = 1.0 - cos
    let sin: SCNFloat = SCNFloat(sinf(Float(radians)))
    
    let m = SCNMatrix4(
        m11: cos + cosp * v.x * v.x,
        m12: cosp * v.x * v.y + v.z * sin,
        m13: cosp * v.x * v.z - v.y * sin,
        m14: 0.0,
        m21: cosp * v.x * v.y - v.z * sin,
        m22: cos + cosp * v.y * v.y,
        m23: cosp * v.y * v.z + v.x * sin,
        m24: 0.0,
        m31: cosp * v.x * v.z + v.y * sin,
        m32: cosp * v.y * v.z - v.x * sin,
        m33: cos + cosp * v.z * v.z,
        m34: 0.0,
        m41: 0.0,
        m42: 0.0,
        m43: 0.0,
        m44: 1.0
    )
    return m
}
   
@inlinable func SCNMatrix4MakeXRotation(_ radians: SCNFloat) -> SCNMatrix4 {
    let cos: SCNFloat = SCNFloat(cosf(Float(radians)))
    let sin: SCNFloat = SCNFloat(sinf(Float(radians)))
    
    let m = SCNMatrix4(
        m11: 1.0, m12: 0.0,  m13: 0.0, m14: 0.0,
        m21: 0.0, m22: cos,  m23: sin, m24: 0.0,
        m31: 0.0, m32: -sin, m33: cos, m34: 0.0,
        m41: 0.0, m42: 0.0,  m43: 0.0, m44: 1.0
    )
    return m;
}

@inlinable func SCNMatrix4MakeYRotation(_ radians: SCNFloat) -> SCNMatrix4 {
    let cos: SCNFloat = SCNFloat(cosf(Float(radians)))
    let sin: SCNFloat = SCNFloat(sinf(Float(radians)))
    
    let m = SCNMatrix4(
        m11: cos, m12: 0.0, m13: -sin, m14: 0.0,
        m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0,
        m31: sin, m32: 0.0, m33: cos, m34: 0.0,
        m41: 0.0, m42: 0.0, m43: 0.0, m44: 1.0
    )
    
    return m
}

@inlinable func SCNMatrix4MakeZRotation(_ radians: SCNFloat) -> SCNMatrix4 {
    let cos: SCNFloat = SCNFloat(cosf(Float(radians)))
    let sin: SCNFloat = SCNFloat(sinf(Float(radians)))
    
    let m = SCNMatrix4(
        m11: cos, m12: sin, m13: 0.0, m14: 0.0,
        m21: -sin, m22: cos, m23: 0.0, m24: 0.0,
        m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0,
        m41: 0.0, m42: 0.0, m43: 0.0, m44: 1.0
    )
    
    return m
}
 
@inlinable func SCNMatrix4MakePerspective(_ fovyRadians: SCNFloat, _ aspect: SCNFloat, _ nearZ: SCNFloat, _ farZ: SCNFloat) -> SCNMatrix4 {
    let cotan: SCNFloat = SCNFloat(1.0 / tanf(Float(fovyRadians / 2.0)))
    
    let m = SCNMatrix4(
        m11: cotan / aspect, m12: 0.0, m13: 0.0, m14: 0.0,
        m21: 0.0, m22: cotan, m23: 0.0, m24: 0.0,
        m31: 0.0, m32: 0.0, m33: (farZ + nearZ) / (nearZ - farZ), m34: -1.0,
        m41: 0.0, m42: 0.0, m43: (2.0 * farZ * nearZ) / (nearZ - farZ), m44: 0.0
    )
    
    return m;
}
    
@inlinable func SCNMatrix4MakeFrustum(_ left: SCNFloat, _ right: SCNFloat,
                                      _ bottom: SCNFloat, _ top: SCNFloat,
                                      _ nearZ: SCNFloat, _ farZ: SCNFloat) -> SCNMatrix4 {
    let ral = right + left
    let rsl = right - left
    let tsb = top - bottom
    let tab = top + bottom
    let fan = farZ + nearZ
    let fsn = farZ - nearZ
    
    let m = SCNMatrix4(
        m11: 2.0 * nearZ / rsl, m12: 0.0, m13: 0.0, m14: 0.0,
        m21: 0.0, m22: 2.0 * nearZ / tsb, m23: 0.0, m24: 0.0,
        m31: ral / rsl, m32: tab / tsb, m33: -fan / fsn, m34: -1.0,
        m41: 0.0, m42: 0.0, m43: (-2.0 * farZ * nearZ) / fsn, m44: 0.0
    )
    
    return m
}
    
@inlinable func SCNMatrix4MakeOrtho(_ left: SCNFloat, _ right: SCNFloat,
                                    _ bottom: SCNFloat, _ top: SCNFloat,
                                    _ nearZ: SCNFloat, _ farZ: SCNFloat) -> SCNMatrix4 {
    let ral = right + left
    let rsl = right - left
    let tab = top + bottom
    let tsb = top - bottom
    let fan = farZ + nearZ
    let fsn = farZ - nearZ
    
    let m = SCNMatrix4(
        m11: 2.0 / rsl, m12: 0.0, m13: 0.0, m14: 0.0,
        m21: 0.0, m22: 2.0 / tsb, m23: 0.0, m24: 0.0,
        m31: 0.0, m32: 0.0, m33: -2.0 / fsn, m34: 0.0,
        m41: -ral / rsl, m42: -tab / tsb, m43: -fan / fsn, m44: 1.0
    )
                     
    return m;
}
   
@inlinable func SCNMatrix4MakeLookAt(_ eyeX: SCNFloat, _ eyeY: SCNFloat, _ eyeZ: SCNFloat,
                                     _ centerX: SCNFloat, _ centerY: SCNFloat, _ centerZ: SCNFloat,
                                     _ upX: SCNFloat, _ upY: SCNFloat, _ upZ: SCNFloat) -> SCNMatrix4 {
    let ev: SCNVector3 = SCNVector3(eyeX, eyeY, eyeZ)
    let cv: SCNVector3 = SCNVector3(centerX, centerY, centerZ)
    let uv: SCNVector3 = SCNVector3(upX, upY, upZ)
    let n: SCNVector3 = SCNVector3Normalize(SCNVector3Add(ev, SCNVector3Negate(cv)))
    let u: SCNVector3 = SCNVector3Normalize(SCNVector3CrossProduct(uv, n))
    let v: SCNVector3 = SCNVector3CrossProduct(n, u)
    
    let m = SCNMatrix4( m11: u.x, m12: v.x, m13: n.x, m14: 0.0,
                        m21: u.y, m22: v.y, m23: n.y, m24: 0.0,
                        m31: u.z, m32: v.z, m33: n.z, m34: 0.0,
                        m41: SCNVector3DotProduct(SCNVector3Negate(u), ev),
                        m42: SCNVector3DotProduct(SCNVector3Negate(v), ev),
                        m43: SCNVector3DotProduct(SCNVector3Negate(n), ev),
                        m44: 1.0)
    
    return m
}
    
@inlinable func SCNMatrix4Transpose(_ matrix: SCNMatrix4) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11, m12: matrix.m21, m13: matrix.m31, m14: matrix.m41,
        m21: matrix.m12, m22: matrix.m22, m23: matrix.m32, m24: matrix.m42,
        m31: matrix.m13, m32: matrix.m23, m33: matrix.m33, m34: matrix.m43,
        m41: matrix.m14, m42: matrix.m24, m43: matrix.m34, m44: matrix.m44
    )
    return m
}

@inlinable func SCNMatrix4Multiply(_ matrixLeft: SCNMatrix4, _ matrixRight: SCNMatrix4) -> SCNMatrix4 {
    var m = SCNMatrix4()
    
    m.m11  = matrixLeft.m11 * matrixRight.m11  + matrixLeft.m21 * matrixRight.m12  + matrixLeft.m31 * matrixRight.m13   + matrixLeft.m41 * matrixRight.m14;
    m.m21  = matrixLeft.m11 * matrixRight.m21  + matrixLeft.m21 * matrixRight.m22  + matrixLeft.m31 * matrixRight.m23   + matrixLeft.m41 * matrixRight.m24
    m.m31  = matrixLeft.m11 * matrixRight.m31  + matrixLeft.m21 * matrixRight.m32  + matrixLeft.m31 * matrixRight.m33  + matrixLeft.m41 * matrixRight.m34;
    m.m41 = matrixLeft.m11 * matrixRight.m41 + matrixLeft.m21 * matrixRight.m42 + matrixLeft.m31 * matrixRight.m43  + matrixLeft.m41 * matrixRight.m44;
    
    m.m12  = matrixLeft.m12 * matrixRight.m11  + matrixLeft.m22 * matrixRight.m12  + matrixLeft.m32 * matrixRight.m13   + matrixLeft.m42 * matrixRight.m14;
    m.m22  = matrixLeft.m12 * matrixRight.m21  + matrixLeft.m22 * matrixRight.m22  + matrixLeft.m32 * matrixRight.m23   + matrixLeft.m42 * matrixRight.m24;
    m.m32  = matrixLeft.m12 * matrixRight.m31  + matrixLeft.m22 * matrixRight.m32  + matrixLeft.m32 * matrixRight.m33  + matrixLeft.m42 * matrixRight.m34;
    m.m42 = matrixLeft.m12 * matrixRight.m41 + matrixLeft.m22 * matrixRight.m42 + matrixLeft.m32 * matrixRight.m43  + matrixLeft.m42 * matrixRight.m44;
    
    m.m13  = matrixLeft.m13 * matrixRight.m11  + matrixLeft.m23 * matrixRight.m12  + matrixLeft.m33 * matrixRight.m13  + matrixLeft.m43 * matrixRight.m14;
    m.m23  = matrixLeft.m13 * matrixRight.m21  + matrixLeft.m23 * matrixRight.m22  + matrixLeft.m33 * matrixRight.m23  + matrixLeft.m43 * matrixRight.m24;
    m.m33 = matrixLeft.m13 * matrixRight.m31  + matrixLeft.m23 * matrixRight.m32  + matrixLeft.m33 * matrixRight.m33 + matrixLeft.m43 * matrixRight.m34;
    m.m43 = matrixLeft.m13 * matrixRight.m41 + matrixLeft.m23 * matrixRight.m42 + matrixLeft.m33 * matrixRight.m43 + matrixLeft.m43 * matrixRight.m44;
    
    m.m14  = matrixLeft.m14 * matrixRight.m11  + matrixLeft.m24 * matrixRight.m12  + matrixLeft.m34 * matrixRight.m13  + matrixLeft.m44 * matrixRight.m14;
    m.m24  = matrixLeft.m14 * matrixRight.m21  + matrixLeft.m24 * matrixRight.m22  + matrixLeft.m34 * matrixRight.m23  + matrixLeft.m44 * matrixRight.m24;
    m.m34 = matrixLeft.m14 * matrixRight.m31  + matrixLeft.m24 * matrixRight.m32  + matrixLeft.m34 * matrixRight.m33 + matrixLeft.m44 * matrixRight.m34;
    m.m44 = matrixLeft.m14 * matrixRight.m41 + matrixLeft.m24 * matrixRight.m42 + matrixLeft.m34 * matrixRight.m43 + matrixLeft.m44 * matrixRight.m44;
    
    return m
}
 
@inlinable func SCNMatrix4Add(_ matrixLeft: SCNMatrix4, _ matrixRight: SCNMatrix4) -> SCNMatrix4 {
    var m: SCNMatrix4 = SCNMatrix4()
    
    m.m11 = matrixLeft.m11 + matrixRight.m11;
    m.m12 = matrixLeft.m12 + matrixRight.m12;
    m.m13 = matrixLeft.m13 + matrixRight.m13;
    m.m14 = matrixLeft.m14 + matrixRight.m14;
    
    m.m21 = matrixLeft.m21 + matrixRight.m21;
    m.m22 = matrixLeft.m22 + matrixRight.m22;
    m.m23 = matrixLeft.m23 + matrixRight.m23;
    m.m24 = matrixLeft.m24 + matrixRight.m24;
    
    m.m31 = matrixLeft.m31 + matrixRight.m31;
    m.m32 = matrixLeft.m32 + matrixRight.m32;
    m.m33 = matrixLeft.m33 + matrixRight.m33;
    m.m34 = matrixLeft.m34 + matrixRight.m34;
    
    m.m41 = matrixLeft.m41 + matrixRight.m41;
    m.m42 = matrixLeft.m42 + matrixRight.m42;
    m.m43 = matrixLeft.m43 + matrixRight.m43;
    m.m44 = matrixLeft.m44 + matrixRight.m44;
    
    return m
}

@inlinable func SCNMatrix4Subtract(_ matrixLeft: SCNMatrix4, _ matrixRight: SCNMatrix4) -> SCNMatrix4 {
    var m: SCNMatrix4 = SCNMatrix4()
    
    m.m11 = matrixLeft.m11 - matrixRight.m11;
    m.m12 = matrixLeft.m12 - matrixRight.m12;
    m.m13 = matrixLeft.m13 - matrixRight.m13;
    m.m14 = matrixLeft.m14 - matrixRight.m14;
    
    m.m21 = matrixLeft.m21 - matrixRight.m21;
    m.m22 = matrixLeft.m22 - matrixRight.m22;
    m.m23 = matrixLeft.m23 - matrixRight.m23;
    m.m24 = matrixLeft.m24 - matrixRight.m24;
    
    m.m31 = matrixLeft.m31 - matrixRight.m31;
    m.m32 = matrixLeft.m32 - matrixRight.m32;
    m.m33 = matrixLeft.m33 - matrixRight.m33;
    m.m34 = matrixLeft.m34 - matrixRight.m34;
    
    m.m41 = matrixLeft.m41 - matrixRight.m41;
    m.m42 = matrixLeft.m42 - matrixRight.m42;
    m.m43 = matrixLeft.m43 - matrixRight.m43;
    m.m44 = matrixLeft.m44 - matrixRight.m44;
    
    return m
}
    
@inlinable func SCNMatrix4Translate(_ matrix: SCNMatrix4, _ tx: SCNFloat, _ ty: SCNFloat, _ tz: SCNFloat) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11, m12: matrix.m12, m13: matrix.m13, m14: matrix.m14,
        m21: matrix.m21, m22: matrix.m22, m23: matrix.m23, m24: matrix.m24,
        m31: matrix.m31, m32: matrix.m32, m33: matrix.m33, m34: matrix.m34,
        m41: matrix.m11 * tx + matrix.m21 * ty + matrix.m31 * tz + matrix.m41,
        m42: matrix.m12 * tx + matrix.m22 * ty + matrix.m32 * tz + matrix.m42,
        m43: matrix.m13 * tx + matrix.m23 * ty + matrix.m33 * tz + matrix.m43,
        m44: matrix.m14 * tx + matrix.m24 * ty + matrix.m34 * tz + matrix.m44
    )
    return m;
}
 
@inlinable func SCNMatrix4TranslateWithVector3(_ matrix: SCNMatrix4, _ translationVector: SCNVector3) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11, m12: matrix.m12, m13: matrix.m13, m14: matrix.m14,
        m21: matrix.m21, m22: matrix.m22, m23: matrix.m23, m24: matrix.m24,
        m31: matrix.m31, m32: matrix.m32, m33: matrix.m33, m34: matrix.m34,
        m41: matrix.m11 * translationVector.x + matrix.m21 * translationVector.y + matrix.m31 * translationVector.z + matrix.m41,
        m42: matrix.m12 * translationVector.x + matrix.m22 * translationVector.y + matrix.m32 * translationVector.z + matrix.m42,
        m43: matrix.m13 * translationVector.x + matrix.m23 * translationVector.y + matrix.m33 * translationVector.z + matrix.m43,
        m44: matrix.m14 * translationVector.x + matrix.m24 * translationVector.y + matrix.m34 * translationVector.z + matrix.m44
    )
    return m;
}
    
@inlinable func SCNMatrix4TranslateWithVector4(_ matrix: SCNMatrix4, _ translationVector: SCNVector4) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11, m12: matrix.m12, m13: matrix.m13, m14: matrix.m14,
        m21: matrix.m21, m22: matrix.m22, m23: matrix.m23, m24: matrix.m24,
        m31: matrix.m31, m32: matrix.m32, m33: matrix.m33, m34: matrix.m34,
        m41: matrix.m11 * translationVector.x + matrix.m21 * translationVector.y + matrix.m31 * translationVector.z + matrix.m41,
        m42: matrix.m12 * translationVector.x + matrix.m22 * translationVector.y + matrix.m32 * translationVector.z + matrix.m42,
        m43: matrix.m13 * translationVector.x + matrix.m23 * translationVector.y + matrix.m33 * translationVector.z + matrix.m43,
        m44: matrix.m14 * translationVector.x + matrix.m24 * translationVector.y + matrix.m34 * translationVector.z + matrix.m44
    )
    return m
}
    
@inlinable func SCNMatrix4Scale(_ matrix: SCNMatrix4, _ sx: SCNFloat, _ sy: SCNFloat, _ sz: SCNFloat) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11 * sx, m12: matrix.m12 * sx, m13: matrix.m13 * sx, m14: matrix.m14 * sx,
        m21: matrix.m21 * sy, m22: matrix.m22 * sy, m23: matrix.m23 * sy, m24: matrix.m24 * sy,
        m31: matrix.m31 * sz, m32: matrix.m32 * sz, m33: matrix.m33 * sz, m34: matrix.m34 * sz,
        m41: matrix.m41, m42: matrix.m42, m43: matrix.m43, m44: matrix.m44
    )
    return m;
}

@inlinable func SCNMatrix4ScaleWithVector3(_ matrix: SCNMatrix4, _ scaleVector: SCNVector3) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11 * scaleVector.x, m12: matrix.m12 * scaleVector.x, m13: matrix.m13 * scaleVector.x, m14: matrix.m14 * scaleVector.x,
        m21: matrix.m21 * scaleVector.y, m22: matrix.m22 * scaleVector.y, m23: matrix.m23 * scaleVector.y, m24: matrix.m24 * scaleVector.y,
        m31: matrix.m31 * scaleVector.z, m32: matrix.m32 * scaleVector.z, m33: matrix.m33 * scaleVector.z, m34: matrix.m34 * scaleVector.z,
        m41: matrix.m41, m42: matrix.m42, m43: matrix.m43, m44: matrix.m44
    )
    return m;
}

@inlinable func SCNMatrix4ScaleWithVector4(_ matrix: SCNMatrix4, _ scaleVector: SCNVector4) -> SCNMatrix4 {
    let m = SCNMatrix4(
        m11: matrix.m11 * scaleVector.x, m12: matrix.m12 * scaleVector.x, m13: matrix.m13 * scaleVector.x, m14: matrix.m14 * scaleVector.x,
        m21: matrix.m21 * scaleVector.y, m22: matrix.m22 * scaleVector.y, m23: matrix.m23 * scaleVector.y, m24: matrix.m24 * scaleVector.y,
        m31: matrix.m31 * scaleVector.z, m32: matrix.m32 * scaleVector.z, m33: matrix.m33 * scaleVector.z, m34: matrix.m34 * scaleVector.z,
        m41: matrix.m41, m42: matrix.m42, m43: matrix.m43, m44: matrix.m44
    )
    return m;
}

@inlinable func SCNMatrix4Rotate(_ matrix: SCNMatrix4, _ radians: SCNFloat, _ x: SCNFloat, _ y: SCNFloat, _ z: SCNFloat) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeRotation(radians, x, y, z)
    return SCNMatrix4Multiply(matrix, rm)
}

@inlinable func SCNMatrix4RotateWithVector3(_ matrix: SCNMatrix4, _ radians: SCNFloat, _ axisVector: SCNVector3) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeRotation(radians, axisVector.x, axisVector.y, axisVector.z)
    return SCNMatrix4Multiply(matrix, rm)
}

@inlinable func SCNMatrix4RotateWithVector4(_ matrix: SCNMatrix4, _ radians: SCNFloat, _ axisVector: SCNVector4) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeRotation(radians, axisVector.x, axisVector.y, axisVector.z)
    return SCNMatrix4Multiply(matrix, rm)
}
    
@inlinable func SCNMatrix4RotateX(_ matrix: SCNMatrix4, _ radians: SCNFloat) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeXRotation(radians)
    return SCNMatrix4Multiply(matrix, rm)
}

@inlinable func SCNMatrix4RotateY(_ matrix: SCNMatrix4, _ radians: SCNFloat) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeYRotation(radians)
    return SCNMatrix4Multiply(matrix, rm)
}

@inlinable func SCNMatrix4RotateZ(_ matrix: SCNMatrix4, _ radians: SCNFloat) -> SCNMatrix4 {
    let rm = SCNMatrix4MakeZRotation(radians)
    return SCNMatrix4Multiply(matrix, rm)
}
    
@inlinable func SCNMatrix4MultiplyVector3(_ matrixLeft: SCNMatrix4, _ vectorRight: SCNVector3) -> SCNVector3 {
    let v4 = SCNMatrix4MultiplyVector4(matrixLeft, SCNVector4Make(vectorRight.x, vectorRight.y, vectorRight.z, 0.0))
    return SCNVector3Make(v4.x, v4.y, v4.z)
}

@inlinable func SCNMatrix4MultiplyVector3WithTranslation(_ matrixLeft: SCNMatrix4, _ vectorRight: SCNVector3) -> SCNVector3 {
    let v4 = SCNMatrix4MultiplyVector4(matrixLeft, SCNVector4Make(vectorRight.x, vectorRight.y, vectorRight.z, 1.0))
    return SCNVector3Make(v4.x, v4.y, v4.z)
}
    
@inlinable func SCNMatrix4MultiplyAndProjectVector3(_ matrixLeft: SCNMatrix4, _ vectorRight: SCNVector3) -> SCNVector3 {
    let v4 = SCNMatrix4MultiplyVector4(matrixLeft, SCNVector4Make(vectorRight.x, vectorRight.y, vectorRight.z, 1.0))
    return SCNVector3MultiplyScalar(SCNVector3Make(v4.x, v4.y, v4.z), 1.0 / v4.w)
}

@inlinable func SCNMatrix4MultiplyVector4(_ matrixLeft: SCNMatrix4, _ vectorRight: SCNVector4) -> SCNVector4 {
    let v = SCNVector4(
        matrixLeft.m11 * vectorRight.x + matrixLeft.m21 * vectorRight.y + matrixLeft.m31 * vectorRight.z + matrixLeft.m41 * vectorRight.w,
        matrixLeft.m12 * vectorRight.x + matrixLeft.m22 * vectorRight.y + matrixLeft.m32 * vectorRight.z + matrixLeft.m42 * vectorRight.w,
        matrixLeft.m13 * vectorRight.x + matrixLeft.m23 * vectorRight.y + matrixLeft.m33 * vectorRight.z + matrixLeft.m43 * vectorRight.w,
        matrixLeft.m14 * vectorRight.x + matrixLeft.m24 * vectorRight.y + matrixLeft.m34 * vectorRight.z + matrixLeft.m44 * vectorRight.w
    )
    return v;
}

