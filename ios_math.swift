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
    
    func dot(other: Vector3) -> Float {
        return (x * other.x + y * other.y + z * other.z)
    }
    
    func cross(other: Vector3) -> Vector3 {
        return Vector3(x: (y * other.z) - (z * other.y), y: (z * other.x) - (x * other.z), z: (x * other.y) - (y * other.x))
    }
}

func + (l: Vector3, r: Vector3) -> Vector3 {
    return Vector3(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
}

func - (l: Vector3, r: Vector3) -> Vector3 {
    return Vector3(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z)
}

func * (v: Vector3, s: Float) -> Vector3 {
    return Vector3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func * (s: Float, v: Vector3) -> Vector3 {
    return v * s
}

func / (v: Vector3, s: Float) -> Vector3 {
    return Vector3(x: v.x / s, y: v.y / s, z: v.z / s)
}
