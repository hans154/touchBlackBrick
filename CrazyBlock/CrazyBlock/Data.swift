//
//  Data.swift
//  CrazyBlock
//
//  Created by 天空air on 14-6-7.
//  Copyright (c) 2014年 air. All rights reserved.
//

import Foundation

class Data
{
    class func getData() -> VOPosition[]
    {
        var temp = VOPosition[]()
        var vo:VOPosition
        var generator = LinearCongruentialGenerator()
        
        
        for i in 0..50
        {
            var r = Int(generator.random() * 4)
            vo = VOPosition(_x :r, _y : i)
            temp.append(vo)
        }
        return temp
    }
}