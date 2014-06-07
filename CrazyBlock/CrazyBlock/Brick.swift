//
//  Brick.swift
//  CrazyBlock
//
//  Created by lwh on 14-6-6.
//  Copyright (c) 2014年 air. All rights reserved.
//

import Foundation
import SpriteKit

class Brick : SKSpriteNode
{
    let NORMAL:Int = 1
    let BLACK:Int = 2
    let GRAY:Int = 3
    let ERROR:Int = 4
    let START:Int = 5
    
    let bg:SKShapeNode = SKShapeNode()
    
    var xIndex:Int = 0
    var yIndex:Int = 0
    
    var curState = 1
    
    init(w:Float, h:Float, xIndex:Int, yIndex:Int)
    {
        super.init(texture: nil, color: nil, size: CGSize(width:w, height:h))
        
        self.xIndex = xIndex
        self.yIndex = yIndex
        
        self.color = UIColor.grayColor()
    }
    
    
    func setState(state:Int)
    {
        curState = state
        switch state
        {
        case 1:
            self.color = UIColor.whiteColor()
        case 2:
            self.color = UIColor.blackColor()
        case 3:
            self.color = UIColor.grayColor()
        case 4:
            self.color = UIColor.redColor()
        case 5:
            self.color = UIColor.yellowColor()
        default:
            println("error state")
        }
        
    }
    
}