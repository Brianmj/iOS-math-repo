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
