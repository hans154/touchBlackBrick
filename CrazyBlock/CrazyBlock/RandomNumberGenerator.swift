//
//  RandomNumberGenerator.swift
//  CrazyBlock
//
//  Created by 天空air on 14-6-7.
//  Copyright (c) 2014年 air. All rights reserved.
//

import Foundation

protocol RandomNumberGenerator {
    func random() -> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}