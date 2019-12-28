import SceneKit
// https://github.com/jamesjlinden/unity-decompiled/blob/master/UnityEngine/UnityEngine/Transform.cs
// https://wiki.unity3d.com/index.php/3d_Math_functions
// https://github.com/lordofduct/spacepuppy-unity-framework-3.0/blob/master/SpacepuppyUnityFramework/Utils/TransformUtil.cs#L51
// https://www.euclideanspace.com

public enum Space {
    case `self`
    case world
}

@available(OSX 10.13, *)
@available(iOS 11.0, *)
extension Uni where Base == SCNNode {
    public var localPosition: SCNVector3 {
        get { base.position }
        set { base.position = newValue }
    }
    
    public var position: SCNVector3 {
        get { base.worldPosition }
        set { base.worldPosition = newValue }
    }
    
    public var localRotation: SCNQuaternion {
        get { base.rotation }
        set { base.rotation = newValue }
    }
    
    var rotation: SCNQuaternion {
        get { fatalError() }
        set { fatalError() }
    }
    
    public var localEulerAngles: SCNVector3 {
        get { base.eulerAngles }
        set { base.eulerAngles = newValue }
    }
    
    var eulerAngles: SCNVector3 {
        get { fatalError() }
        set { fatalError() }
    }
    
    public var right: SCNVector3 {
        get { self.rotation * SCNVector3.right }
        set { self.rotation = SCNQuaternion(from: SCNVector3.right, to: newValue) }
    }
    
    public var forward: SCNVector3 {
        get { self.rotation * SCNVector3.forward }
        set { self.rotation = SCNQuaternion.lookRotation(newValue) }
    }
    
    var worldToLocalMatrix: SCNMatrix4 {
        fatalError()
    }
    
    var localToWorldMatrix: SCNMatrix4 {
        fatalError()
    }
    
    public var root: SCNNode {
        getRoot(for: base)
    }
    
    private func getRoot(for node: SCNNode) -> SCNNode {
        if let node = node.parent {
            return getRoot(for: node)
        } else {
            return node
        }
    }
    
    public var childCount: Int {
        base.childNodes.count
    }
    
    var lossyScale: SCNVector3 {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Moves the transform in the direction and distance of translation.</para>
    /// </summary>
    /// <param name="translation"></param>
    /// <param name="relativeTo"></param>
    public func translate(_ translation: SCNVector3, relativeTo: Space = .`self`) {
        if relativeTo == .world {
            self.position += translation
        } else {
            self.position += self.transformDirection(direction: translation)
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
        fatalError()
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
    
    /// <summary>
    ///   <para>Applies a rotation of eulerAngles.z degrees around the z axis, eulerAngles.x degrees around the x axis, and eulerAngles.y degrees around the y axis (in that order).</para>
    /// </summary>
    /// <param name="eulerAngles"></param>
    /// <param name="relativeTo"></param>
    public func rotate(_ eulerAngles: SCNVector3, relativeTo: Space = .`self`) {
        fatalError()
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
        fatalError()
    }
    
    /// <summary>
    ///   <para>Rotates the transform about axis passing through point in world coordinates by angle degrees.</para>
    /// </summary>
    /// <param name="point"></param>
    /// <param name="axis"></param>
    /// <param name="angle"></param>
    public func rotateAround(point: SCNVector3, axis: SCNVector3, angle: SCNFloat) {
        let position = self.position
        let vector3 = SCNQuaternion.angleAxis(angle, axis: axis) * (position - point)
        self.position = point + vector3
        
        self.rotateAroundInternal(axis: axis, angle: angle * (SCNFloat.pi / 180.0))
    }
    
    /// <summary>
    ///   <para>Rotates the transform so the forward vector points at target's current position.</para>
    /// </summary>
    /// <param name="target">Object to point towards.</param>
    /// <param name="worldUp">Vector specifying the upward direction.</param>
    public func lookAt(_ target: SCNNode?, worldUp: SCNVector3 = .up) {
        guard let target = target else { return }
        lookAt(target.uni.position, worldUp: worldUp)
    }
    
    /// <summary>
    ///   <para>Rotates the transform so the forward vector points at worldPosition.</para>
    /// </summary>
    /// <param name="worldPosition">Point to look at.</param>
    /// <param name="worldUp">Vector specifying the upward direction.</param>
    public func lookAt(_ worldPosition: SCNVector3, worldUp: SCNVector3 = .up) {
        self.base.look(at: worldPosition, up: worldUp, localFront: SCNNode.localFront)
    }
    
    /// <summary>
    ///   <para>Transforms direction from local space to world space.</para>
    /// </summary>
    /// <param name="direction"></param>
    public func transformDirection(direction: SCNVector3) -> SCNVector3 {
        self.rotation * direction
    }
    
    /// <summary>
    ///   <para>Transforms direction x, y, z from local space to world space.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func transformDirection(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        self.transformDirection(direction: SCNVector3(x, y, z))
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
        self.transformVector(SCNVector3(x, y, z))
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
    
    /// <summary>
    ///   <para>Transforms position from local space to world space.</para>
    /// </summary>
    /// <param name="position"></param>
    public func transformPoint(position: SCNVector3) -> SCNVector3 {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Transforms the position x, y, z from local space to world space.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func transformPoint(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        return self.transformPoint(position: SCNVector3(x, y, z))
    }
    
    /// <summary>
    ///   <para>Transforms position from world space to local space.</para>
    /// </summary>
    /// <param name="position"></param>
    public func inverseTransformPoint(position: SCNVector3) -> SCNVector3 {
        fatalError()
    }
    
    /// <summary>
    ///   <para>Transforms the position x, y, z from world space to local space. The opposite of Transform.TransformPoint.</para>
    /// </summary>
    /// <param name="x"></param>
    /// <param name="y"></param>
    /// <param name="z"></param>
    public func inverseTransformPoint(x: SCNFloat, y: SCNFloat, z: SCNFloat) -> SCNVector3 {
        return self.inverseTransformPoint(position: SCNVector3(x, y, z))
    }

    public func detachChildren() {
        fatalError()
    }
    
    public func setAsFirstSibling() {
        
    }
    
    public func setAsLastSibling() {
        
    }
    
    public func setSiblingIndex(index: Int) {
        
    }
    
    public func getSiblingIndex() -> Int {
        fatalError()
    }
    
    public func find(name: String) -> SCNNode? {
        base.childNode(withName: name, recursively: true)
    }
    
    public func isChildOf(parent: SCNNode) -> Bool {
        parent.childNodes.contains(base)
    }
    
    public func findChild(name: String) -> SCNNode? {
        self.find(name: name)
    }
    
    /// <summary>
    ///   <para></para>
    /// </summary>
    /// <param name="axis"></param>
    /// <param name="angle"></param>
    public func rotateAround(axis: SCNVector3, angle: SCNFloat) {
        fatalError()
    }
    
    public func rotateAroundLocal(axis: SCNVector3, angle: SCNFloat) {
        fatalError()
    }
}
