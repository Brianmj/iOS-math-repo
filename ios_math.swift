//
//  ios_math.swift
//  ios_math
//
//  Created by Brian Jones on 6/15/16.
//  Copyright © 2016 Brian Jones. All rights reserved.
//

import Foundation
import simd

extension Int {
    var degreesToRadians: Float {
        return Float(self) * Float(M_PI) / Float(180.0)
    }
}

extension Float {
    var radiansToDegrees: Float {
        return Float(self) * Float(180.0) / Float(M_PI)
    }
}

struct Vector3 {
    var x, y, z: Float
    
    
    init() {
        x = 0.0
        y = 0.0
        z = 0.0
    }
    
    init(all: Float) {
        x = all
        y = all
        z = all
    }
    
    init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(v: Vector3) {
        x = v.x
        y = v.y
        z = v.z
    }
    
    func length() -> Float {
        return sqrt(x * x + y * y + z * z)
    }
    
    func normalized() -> Vector3 {
        let l = length()
        return Vector3(x: self.x / l, y: y / l, z: z / l)
    }
}

func dot(left: Vector3, other: Vector3) -> Float {
    return (left.x * other.x + left.y * other.y + left.z * other.z)
}

func cross(left: Vector3, other: Vector3) -> Vector3 {
    return Vector3(x: (left.y * other.z) - (left.z * other.y), y: (left.z * other.x) - (left.x * other.z), z: (left.x * other.y) - (left.y * other.x))
}


struct Vector4 {
    var x, y, z, w: Float
    
    init() {
        x = 0.0
        y = 0.0
        z = 0.0
        w = 0.0
    }
    
    init(all: Float) {
        x = all
        y = all
        z = all
        w = all
    }
    
    init(x: Float, y: Float, z: Float, w: Float) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    init(fromVec3: Vector3, w: Float) {
        self.x = fromVec3.x
        self.y = fromVec3.y
        self.z = fromVec3.z
        self.w = w
    }
    
    init(v: Vector4) {
        x = v.x
        y = v.y
        z = v.z
        w = v.w
    }
    
    func length() -> Float {
        return sqrt(x * x + y * y + z * z + w * w)
    }
    
    func normalized() -> Vector4 {
        let l = length()
        return Vector4(x: self.x / l, y: y / l, z: z / l, w: w / l )
    }
    
    func dot(other: Vector4) -> Float {
        return (x * other.x + y * other.y + z * other.z + w * other.w)
    }
}

class Matrix4 {
    // column major matrix
    var elements: [Float] = [Float](repeating: 0.0, count: 16)
    
    init() {
        _ = identity()
    }
    
    func identity() -> Matrix4 {
        elements = elements.map{_ in 0.0}
        elements[0] = 1.0
        elements[5] = 1.0
        elements[10] = 1.0
        elements[15] = 1.0
        return self
    }
    
    class func translate(x: Float, y: Float, z:Float) -> Matrix4 {
        let m = Matrix4()
        m.column3 = Vector4(x: x, y: y, z: z, w: 1.0)
        return m
    }
    class func y_rotation(angle: Float) -> Matrix4 {
        let s = sin(angle)
        let c = cos(angle)
        
        let m = Matrix4()
        m.column0 = Vector4(x: c, y: 0.0, z: -s, w: 0.0)
        m.column2 = Vector4(x: s, y: 0.0, z: c, w: 0.0)
        
        return m
    }
    class func z_rotation(angle: Float) -> Matrix4 {
        let s = sin(angle)
        let c = cos(angle)
        
        let m = Matrix4()
        m.column0 = Vector4(x: c, y: s, z: 0, w: 0)
        m.column1 = Vector4(x: -s, y: c, z: 0.0, w: 0.0)
        
        return m
    }
}

func + (l: Vector3, r: Vector3) -> Vector3 {
    return Vector3(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
}

func + (l: Vector4, r: Vector4) -> Vector4 {
    return Vector4(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z, w: l.w + r.w)
}

func - (l: Vector3, r: Vector3) -> Vector3 {
    return Vector3(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z)
}

func - (l: Vector4, r: Vector4) -> Vector4 {
    return Vector4(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z, w: l.w - r.w)
}

func * (v: Vector3, s: Float) -> Vector3 {
    return Vector3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func * (v: Vector4, s: Float) -> Vector4 {
    return Vector4(x: v.x * s, y: v.y * s, z: v.z * s, w:  v.w * s)
}

func * (s: Float, v: Vector3) -> Vector3 {
    return v * s
}

func * (s: Float, v: Vector4) -> Vector4 {
    return v * s
}

func / (v: Vector3, s: Float) -> Vector3 {
    return Vector3(x: v.x / s, y: v.y / s, z: v.z / s)
}

func / (v: Vector4, s: Float) -> Vector4 {
    return Vector4(x: v.x / s, y: v.y / s, z: v.z / s, w: v.w / s)
}

prefix func - (v: Vector3) -> Vector3 {
    return Vector3(x: -v.x, y: -v.y, z: -v.z)
}

prefix func - (v: Vector4) -> Vector4 {
    return Vector4(x: -v.x, y: -v.y, z: -v.z, w: -v.w)
}

func * (m: Matrix4, v: Vector4) -> Vector4 {
    var result = Vector4()
    result.x = m.row0.dot(other: v)
    result.y = m.row1.dot(other: v)
    result.z = m.row2.dot(other: v)
    result.w = m.row3.dot(other: v)
    
    return result
}

extension Vector3 {
    var array: [Float] {
        get {
            return [x, y, z]
        }
        
        set {
            x = newValue[0]
            y = newValue[1]
            z = newValue[2]
        }
    }
}

extension Vector4 {
    func toVector3() -> Vector3 {
        return Vector3(x: self.x, y: self.y, z: self.z)
    }
    
    var array: [Float] {
        get {
            return [x, y, z, w]
        }
        
        set {
            x = newValue[0]
            y = newValue[1]
            z = newValue[2]
            w = newValue[3]
        }
    }
}

extension Matrix4 {
    var row0: Vector4 {
        get {
            return Vector4(x: elements[0], y: elements[4], z: elements[8], w: elements[12])
        }
        
        set {
            elements[0] = newValue.x
            elements[4] = newValue.y
            elements[8] = newValue.z
            elements[12] = newValue.w
        }
    }
    
    var row1: Vector4 {
        get {
            return Vector4(x: elements[1], y: elements[5], z: elements[9], w: elements[13])
        }
        
        set {
            elements[1] = newValue.x
            elements[5] = newValue.y
            elements[9] = newValue.z
            elements[13] = newValue.w
        }
    }
    
    var row2: Vector4 {
        get {
            return Vector4(x: elements[2], y: elements[6], z: elements[10], w: elements[14])
        }
        
        set {
            elements[2] = newValue.x
            elements[6] = newValue.y
            elements[10] = newValue.z
            elements[14] = newValue.w
        }
    }
    
    var row3: Vector4 {
        get {
            return Vector4(x: elements[3], y: elements[7], z: elements[11], w: elements[15])
        }
        
        set {
            elements[3] = newValue.x
            elements[7] = newValue.y
            elements[11] = newValue.z
            elements[15] = newValue.w
        }
    }
    
    var column0: Vector4 {
        get {
            return Vector4(x: elements[0], y: elements[1], z: elements[2], w: elements[3])
        }
        
        set {
            elements[0] = newValue.x; elements[1] = newValue.y; elements[2] = newValue.z; elements[3] = newValue.w
        }
    }
    
    var column1: Vector4 {
        get {
            return Vector4(x: elements[4], y: elements[5], z: elements[6], w: elements[7])
        }
        
        set {
            elements[4] = newValue.x; elements[5] = newValue.y; elements[6] = newValue.z; elements[7] = newValue.w
        }
    }
    
    var column2: Vector4 {
        get {
            return Vector4(x: elements[8], y: elements[9], z: elements[10], w: elements[11])
        }
        
        set {
            elements[8] = newValue.x; elements[9] = newValue.y; elements[10] = newValue.z; elements[11] = newValue.w
        }
    }
    
    var column3: Vector4 {
        get {
            return Vector4(x: elements[12], y: elements[13], z: elements[14], w: elements[15])
        }
        
        set {
            elements[12] = newValue.x; elements[13] = newValue.y; elements[14] = newValue.z; elements[15] = newValue.w
        }
    }

}
