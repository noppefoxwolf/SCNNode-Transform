import SceneKit
// https://github.com/jamesjlinden/unity-decompiled/blob/master/UnityEngine/UnityEngine/Transform.cs

extension SCNNode {
    var worldEulerAngles: SCNVector3 {
        get { rotation.eulerAngles }
        set { rotation = SCNQuaternion.euler(newValue) }
    }
    
    var right: SCNVector3 {
        get { rotation * SCNVector3.right }
        set { rotation = SCNQuaternion(from: .right, to: newValue) }
    }
    
    var forward: SCNVector3 {
        get { rotation * SCNVector3.forward }
        set { rotation = SCNQuaternion.lookRotation(newValue) }
    }
}

extension SCNVector3 {
    static var right: SCNVector3 {
        fatalError()
    }
    
    static var forward: SCNVector3 {
        fatalError()
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
    
    var eulerAngles: SCNVector3 {
        fatalError()
    }
    
    static func inverse(_ value: SCNQuaternion) -> SCNQuaternion {
        fatalError()
    }
}

func * (left: SCNVector4, right: SCNVector3) -> SCNVector3 {
    fatalError()
}

extension SCNNode {
    var worldToLocalMatrix: SCNMatrix4 {
        fatalError()
    }
    
    var localToWorldMatrix: SCNMatrix4 {
        fatalError()
    }
    
    var root: SCNNode? {
        fatalError()
    }
    
    var childCount: Int {
        childNodes.count
    }
    
    var lossyScale: SCNVector3 {
        fatalError()
    }
}

public enum Space {
    case `self`
    case world
}

@available(OSX 10.13, *)
extension SCNNode {
    /// <summary>
    ///   <para>Moves the transform in the direction and distance of translation.</para>
    /// </summary>
    /// <param name="translation"></param>
    /// <param name="relativeTo"></param>
    public func translate(_ translation: SCNVector3, relativeTo: Space = .`self`) {
        if relativeTo == Space.world {
            self.worldPosition += translation
        } else {
            self.worldPosition += self.transformDirection(translation)
        }
    }
    
    /// <summary>
    ///   <para>Moves the transform by x along the x axis, y along the y axis, and z along the z axis.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    /// <param name="relativeTo"></param>
    public func translate(x: SCNFloat, y: SCNFloat, z: SCNFloat, relativeTo: Space = .`self`) {
        self.translate(SCNVector3(x: x, y: y, z: z), relativeTo: relativeTo)
    }

    /// <summary>
    ///   <para>Moves the transform in the direction and distance of translation.</para>
    /// </summary>
    /// <param name="translation"></param>
    /// <param name="relativeTo"></param>
    public func translate(_ translation: SCNVector3, relativeTo: SCNNode?) {
        if let relativeTo = relativeTo {
            self.worldPosition += relativeTo.transformDirection(translation)
        } else {
            self.worldPosition += translation
        }
    }

    /// <summary>
    ///   <para>Moves the transform by x along the x axis, y along the y axis, and z along the z axis.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    /// <param name="relativeTo"></param>
    public func translate(x: SCNFloat, y: SCNFloat, z: SCNFloat, relativeTo: SCNNode) {
        self.translate(SCNVector3(x: x, y: y, z: z), relativeTo: relativeTo)
    }
}

func += (left: inout SCNVector3, right: SCNVector3) {
    fatalError()
}

@available(OSX 10.13, *)
extension SCNNode {
    /// <summary>
    ///   <para>Applies a rotation of eulerAngles.z degrees around the z axis, eulerAngles.x degrees around the x axis, and eulerAngles.y degrees around the y axis (in that order).</para>
    /// </summary>
    /// <param name="eulerAngles"></param>
    /// <param name="relativeTo"></param>
    public func rotate(_ eulerAngles: SCNVector3, relativeTo: Space = .`self`) {
        let quaternion = SCNQuaternion.euler(x: eulerAngles.x, y: eulerAngles.y, z: eulerAngles.z)
        if relativeTo == .`self` {
            self.rotation = self.rotation * quaternion
        } else {
            self.rotation = self.rotation * SCNQuaternion.inverse(self.rotation) * quaternion * self.rotation
        }
    }
    
    /// <summary>
    ///   <para>Applies a rotation of zAngle degrees around the z axis, xAngle degrees around the x axis, and yAngle degrees around the y axis (in that order).</para>
    /// </summary>
    /// <param name="xAngle"></param>
    /// <param name="yAngle"></param>
    /// <param name="zAngle"></param>
    /// <param name="relativeTo"></param>
    public func rotate(xAngle: SCNFloat, yAngle: SCNFloat, zAngle: SCNFloat, relativeTo: Space = .`self`) {
        self.rotate(SCNVector3(xAngle, yAngle, zAngle), relativeTo: relativeTo)
    }
    
    internal func rotateAroundInternal(axis: SCNVector3, angle: SCNFloat) {
        
    }

    /// <summary>
    ///   <para>Rotates the transform around axis by angle degrees.</para>
    /// </summary>
    /// <param name="axis"></param>
    /// <param name="angle"></param>
    /// <param name="relativeTo"></param>
    public func rotate(axis: SCNVector3, angle: SCNFloat, relativeTo: Space = .`self`) {
        if relativeTo == .`self` {
            self.rotateAroundInternal(axis: self.transformDirection(axis), angle: angle * (Float.pi / 180.0))
        } else {
            self.rotateAroundInternal(axis: axis, angle: angle * CGFloat((Float.pi / 180.0)))
        }
    }
    
    /// <summary>
    ///   <para>Rotates the transform about axis passing through point in world coordinates by angle degrees.</para>
    /// </summary>
    /// <param name="point"></param>
    /// <param name="axis"></param>
    /// <param name="angle"></param>
    public func rotateAround(point: SCNVector3, axis: SCNVector3, angle: SCNFloat) {
        let position = self.position
        let vector3 = SCNQuaternion.angleAxis(angle, axis) * (worldPosition - point)
        self.worldPosition = point + vector3
        self.rotateAroundInternal(axis: axis, angle: angle * CGFloat((Float.pi / 180.0)))
    }
    
    /// <summary>
    ///   <para>Rotates the transform so the forward vector points at target's current position.</para>
    /// </summary>
    /// <param name="target">Object to point towards.</param>
    /// <param name="worldUp">Vector specifying the upward direction.</param>
    public func lookAt(_ target: SCNNode?, worldUp: SCNVector3 = .up) {
        guard let target = target else { return }
        lookAt(target.worldPosition, worldUp: worldUp)
    }
    
    /// <summary>
    ///   <para>Rotates the transform so the forward vector points at worldPosition.</para>
    /// </summary>
    /// <param name="worldPosition">Point to look at.</param>
    /// <param name="worldUp">Vector specifying the upward direction.</param>
    public func lookAt(_ worldPosition: SCNVector3, worldUp: SCNVector3 = .up) {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Transforms direction from local space to world space.</para>
    /// </summary>
    /// <param name="direction"></param>
    public func transformDirection(direction: SCNVector3) -> SCNVector3 {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Transforms direction x, y, z from local space to world space.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func transformDirection(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        return transformDirection(direction: SCNVector3(x, y, z))
    }
    
    /// <summary>
    ///   <para>Transforms vector from local space to world space.</para>
    /// </summary>
    /// <param name="vector"></param>
    public func transformVector(_ vector: SCNVector3) -> SCNVector3 {
        fatalError()
    }

    /// <summary>
    ///   <para>Transforms vector x, y, z from local space to world space.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func transformVector(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        return self.transformVector(SCNVector3(x, y, z))
    }
    
    /// <summary>
    ///   <para>Transforms a vector from world space to local space. The opposite of Transform.TransformVector.</para>
    /// </summary>
    /// <param name="vector"></param>
    public func inverseTransformVector(_ vector: SCNVector3) -> SCNVector3 {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Transforms the vector x, y, z from world space to local space. The opposite of Transform.TransformVector.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func inverseTransformVector(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        return self.inverseTransformVector(SCNVector3(x, y, z))
    }
}

func * (left: SCNQuaternion, right: SCNQuaternion) -> SCNQuaternion {
    fatalError()
}

//
//    /// <summary>
//    ///   <para>Applies a rotation of eulerAngles.z degrees around the z axis, eulerAngles.x degrees around the x axis, and eulerAngles.y degrees around the y axis (in that order).</para>
//    /// </summary>
//    /// <param name="eulerAngles"></param>
//    /// <param name="relativeTo"></param>
//    [ExcludeFromDocs]
//    public void Rotate(Vector3 eulerAngles)
//    {
//      Space relativeTo = Space.Self;
//      this.Rotate(eulerAngles, relativeTo);
//    }
//
//    /// <summary>
//    ///   <para>Applies a rotation of eulerAngles.z degrees around the z axis, eulerAngles.x degrees around the x axis, and eulerAngles.y degrees around the y axis (in that order).</para>
//    /// </summary>
//    /// <param name="eulerAngles"></param>
//    /// <param name="relativeTo"></param>
//    public void Rotate(Vector3 eulerAngles, [DefaultValue("Space.Self")] Space relativeTo)
//    {
//      Quaternion quaternion = Quaternion.Euler(eulerAngles.x, eulerAngles.y, eulerAngles.z);
//      if (relativeTo == Space.Self)
//        this.localRotation = this.localRotation * quaternion;
//      else
//        this.rotation = this.rotation * Quaternion.Inverse(this.rotation) * quaternion * this.rotation;
//    }
//
//    /// <summary>
//    ///   <para>Applies a rotation of zAngle degrees around the z axis, xAngle degrees around the x axis, and yAngle degrees around the y axis (in that order).</para>
//    /// </summary>
//    /// <param name="xAngle"></param>
//    /// <param name="yAngle"></param>
//    /// <param name="zAngle"></param>
//    /// <param name="relativeTo"></param>
//    [ExcludeFromDocs]
//    public void Rotate(float xAngle, float yAngle, float zAngle)
//    {
//      Space relativeTo = Space.Self;
//      this.Rotate(xAngle, yAngle, zAngle, relativeTo);
//    }
//
//    /// <summary>
//    ///   <para>Applies a rotation of zAngle degrees around the z axis, xAngle degrees around the x axis, and yAngle degrees around the y axis (in that order).</para>
//    /// </summary>
//    /// <param name="xAngle"></param>
//    /// <param name="yAngle"></param>
//    /// <param name="zAngle"></param>
//    /// <param name="relativeTo"></param>
//    public void Rotate(float xAngle, float yAngle, float zAngle, [DefaultValue("Space.Self")] Space relativeTo)
//    {
//      this.Rotate(new Vector3(xAngle, yAngle, zAngle), relativeTo);
//    }
//
//    internal void RotateAroundInternal(Vector3 axis, float angle)
//    {
//      Transform.INTERNAL_CALL_RotateAroundInternal(this, ref axis, angle);
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_RotateAroundInternal(Transform self, ref Vector3 axis, float angle);
//
//    /// <summary>
//    ///   <para>Rotates the transform around axis by angle degrees.</para>
//    /// </summary>
//    /// <param name="axis"></param>
//    /// <param name="angle"></param>
//    /// <param name="relativeTo"></param>
//    [ExcludeFromDocs]
//    public void Rotate(Vector3 axis, float angle)
//    {
//      Space relativeTo = Space.Self;
//      this.Rotate(axis, angle, relativeTo);
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform around axis by angle degrees.</para>
//    /// </summary>
//    /// <param name="axis"></param>
//    /// <param name="angle"></param>
//    /// <param name="relativeTo"></param>
//    public void Rotate(Vector3 axis, float angle, [DefaultValue("Space.Self")] Space relativeTo)
//    {
//      if (relativeTo == Space.Self)
//        this.RotateAroundInternal(this.transform.TransformDirection(axis), angle * ((float) Math.PI / 180f));
//      else
//        this.RotateAroundInternal(axis, angle * ((float) Math.PI / 180f));
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform about axis passing through point in world coordinates by angle degrees.</para>
//    /// </summary>
//    /// <param name="point"></param>
//    /// <param name="axis"></param>
//    /// <param name="angle"></param>
//    public void RotateAround(Vector3 point, Vector3 axis, float angle)
//    {
//      Vector3 position = this.position;
//      Vector3 vector3 = Quaternion.AngleAxis(angle, axis) * (position - point);
//      this.position = point + vector3;
//      this.RotateAroundInternal(axis, angle * ((float) Math.PI / 180f));
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform so the forward vector points at target's current position.</para>
//    /// </summary>
//    /// <param name="target">Object to point towards.</param>
//    /// <param name="worldUp">Vector specifying the upward direction.</param>
//    [ExcludeFromDocs]
//    public void LookAt(Transform target)
//    {
//      Vector3 up = Vector3.up;
//      this.LookAt(target, up);
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform so the forward vector points at target's current position.</para>
//    /// </summary>
//    /// <param name="target">Object to point towards.</param>
//    /// <param name="worldUp">Vector specifying the upward direction.</param>
//    public void LookAt(Transform target, [DefaultValue("Vector3.up")] Vector3 worldUp)
//    {
//      if (!(bool) ((Object) target))
//        return;
//      this.LookAt(target.position, worldUp);
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform so the forward vector points at worldPosition.</para>
//    /// </summary>
//    /// <param name="worldPosition">Point to look at.</param>
//    /// <param name="worldUp">Vector specifying the upward direction.</param>
//    public void LookAt(Vector3 worldPosition, [DefaultValue("Vector3.up")] Vector3 worldUp)
//    {
//      Transform.INTERNAL_CALL_LookAt(this, ref worldPosition, ref worldUp);
//    }
//
//    /// <summary>
//    ///   <para>Rotates the transform so the forward vector points at worldPosition.</para>
//    /// </summary>
//    /// <param name="worldPosition">Point to look at.</param>
//    /// <param name="worldUp">Vector specifying the upward direction.</param>
//    [ExcludeFromDocs]
//    public void LookAt(Vector3 worldPosition)
//    {
//      Vector3 up = Vector3.up;
//      Transform.INTERNAL_CALL_LookAt(this, ref worldPosition, ref up);
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_LookAt(Transform self, ref Vector3 worldPosition, ref Vector3 worldUp);
//
//    /// <summary>
//    ///   <para>Transforms direction from local space to world space.</para>
//    /// </summary>
//    /// <param name="direction"></param>
//    public Vector3 TransformDirection(Vector3 direction)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_TransformDirection(this, ref direction, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_TransformDirection(Transform self, ref Vector3 direction, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms direction x, y, z from local space to world space.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 TransformDirection(float x, float y, float z)
//    {
//      return this.TransformDirection(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Transforms a direction from world space to local space. The opposite of Transform.TransformDirection.</para>
//    /// </summary>
//    /// <param name="direction"></param>
//    public Vector3 InverseTransformDirection(Vector3 direction)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_InverseTransformDirection(this, ref direction, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_InverseTransformDirection(Transform self, ref Vector3 direction, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms the direction x, y, z from world space to local space. The opposite of Transform.TransformDirection.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 InverseTransformDirection(float x, float y, float z)
//    {
//      return this.InverseTransformDirection(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Transforms vector from local space to world space.</para>
//    /// </summary>
//    /// <param name="vector"></param>
//    public Vector3 TransformVector(Vector3 vector)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_TransformVector(this, ref vector, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_TransformVector(Transform self, ref Vector3 vector, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms vector x, y, z from local space to world space.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 TransformVector(float x, float y, float z)
//    {
//      return this.TransformVector(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Transforms a vector from world space to local space. The opposite of Transform.TransformVector.</para>
//    /// </summary>
//    /// <param name="vector"></param>
//    public Vector3 InverseTransformVector(Vector3 vector)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_InverseTransformVector(this, ref vector, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_InverseTransformVector(Transform self, ref Vector3 vector, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms the vector x, y, z from world space to local space. The opposite of Transform.TransformVector.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 InverseTransformVector(float x, float y, float z)
//    {
//      return this.InverseTransformVector(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Transforms position from local space to world space.</para>
//    /// </summary>
//    /// <param name="position"></param>
//    public Vector3 TransformPoint(Vector3 position)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_TransformPoint(this, ref position, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_TransformPoint(Transform self, ref Vector3 position, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms the position x, y, z from local space to world space.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 TransformPoint(float x, float y, float z)
//    {
//      return this.TransformPoint(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Transforms position from world space to local space.</para>
//    /// </summary>
//    /// <param name="position"></param>
//    public Vector3 InverseTransformPoint(Vector3 position)
//    {
//      Vector3 vector3;
//      Transform.INTERNAL_CALL_InverseTransformPoint(this, ref position, out vector3);
//      return vector3;
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_InverseTransformPoint(Transform self, ref Vector3 position, out Vector3 value);
//
//    /// <summary>
//    ///   <para>Transforms the position x, y, z from world space to local space. The opposite of Transform.TransformPoint.</para>
//    /// </summary>
//    /// <param name="x"></param>
//    /// <param name="y"></param>
//    /// <param name="z"></param>
//    public Vector3 InverseTransformPoint(float x, float y, float z)
//    {
//      return this.InverseTransformPoint(new Vector3(x, y, z));
//    }
//
//    /// <summary>
//    ///   <para>Unparents all children.</para>
//    /// </summary>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public void DetachChildren();
//
//    /// <summary>
//    ///   <para>Move the transform to the start of the local transform list.</para>
//    /// </summary>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public void SetAsFirstSibling();
//
//    /// <summary>
//    ///   <para>Move the transform to the end of the local transform list.</para>
//    /// </summary>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public void SetAsLastSibling();
//
//    /// <summary>
//    ///   <para>Sets the sibling index.</para>
//    /// </summary>
//    /// <param name="index">Index to set.</param>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public void SetSiblingIndex(int index);
//
//    /// <summary>
//    ///   <para>Gets the sibling index.</para>
//    /// </summary>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public int GetSiblingIndex();
//
//    /// <summary>
//    ///   <para>Finds a child by name and returns it.</para>
//    /// </summary>
//    /// <param name="name">Name of child to be found.</param>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public Transform Find(string name);
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    internal void SendTransformChangedScale();
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private void INTERNAL_get_lossyScale(out Vector3 value);
//
//    /// <summary>
//    ///   <para>Is this transform a child of parent?</para>
//    /// </summary>
//    /// <param name="parent"></param>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public bool IsChildOf(Transform parent);
//
//    public Transform FindChild(string name)
//    {
//      return this.Find(name);
//    }
//
//    public IEnumerator GetEnumerator()
//    {
//      return (IEnumerator) new Transform.Enumerator(this);
//    }
//
//    /// <summary>
//    ///   <para></para>
//    /// </summary>
//    /// <param name="axis"></param>
//    /// <param name="angle"></param>
//    [Obsolete("use Transform.Rotate instead.")]
//    public void RotateAround(Vector3 axis, float angle)
//    {
//      Transform.INTERNAL_CALL_RotateAround(this, ref axis, angle);
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_RotateAround(Transform self, ref Vector3 axis, float angle);
//
//    [Obsolete("use Transform.Rotate instead.")]
//    public void RotateAroundLocal(Vector3 axis, float angle)
//    {
//      Transform.INTERNAL_CALL_RotateAroundLocal(this, ref axis, angle);
//    }
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    private static extern void INTERNAL_CALL_RotateAroundLocal(Transform self, ref Vector3 axis, float angle);
//
//    /// <summary>
//    ///   <para>Returns a transform child by index.</para>
//    /// </summary>
//    /// <param name="index">Index of the child transform to return. Must be smaller than Transform.childCount.</param>
//    /// <returns>
//    ///   <para>Transform child by index.</para>
//    /// </returns>
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public Transform GetChild(int index);
//
//    [WrapperlessIcall]
//    [Obsolete("use Transform.childCount instead.")]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    public int GetChildCount();
//
//    [WrapperlessIcall]
//    [MethodImpl(MethodImplOptions.InternalCall)]
//    internal bool IsNonUniformScaleTransform();
//
//    private sealed class Enumerator : IEnumerator
//    {
//      private int currentIndex = -1;
//      private Transform outer;
//
//      public object Current
//      {
//        get
//        {
//          return (object) this.outer.GetChild(this.currentIndex);
//        }
//      }
//
//      internal Enumerator(Transform outer)
//      {
//        this.outer = outer;
//      }
//
//      public bool MoveNext()
//      {
//        return ++this.currentIndex < this.outer.childCount;
//      }
//
//      public void Reset()
//      {
//        this.currentIndex = -1;
//      }
//    }
//  }
//}
