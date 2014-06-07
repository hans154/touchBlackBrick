//
//  GameScene.swift
//  CrazyBlock
//
//  Created by 天空air on 14-6-4.
//  Copyright (c) 2014年 air. All rights reserved.
//
import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var bricks = []

    var fadeOut = SKAction()
    var btCnt = SKSpriteNode()
    var brickCnt = SKSpriteNode()
    
    var isClickStart:Bool = false
    var isGameStarted:Bool = false
    var isGameOver:Bool = false
    
    var delay:Int = 0
    var timeCount:Int = 0
    var countdown:Double = 0.0
    
    let scroeLabel = SKLabelNode(fontNamed:"Chalkduster")
    var myLabel = SKLabelNode(fontNamed:"Chalkduster")
    
    var start:Double = 0.0
    
    var preNodeIndex:Int = -1
    
    
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Click Black Brick"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        myLabel.name = "btStart"
        
        brickCnt.name = "brickCnt"
        self.addChild(brickCnt)
        

        scroeLabel.text = ""
        scroeLabel.fontSize = 38
        scroeLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - 60)
        self.addChild(scroeLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            startGame(touch)
            playGame(touch)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {

        if !isClickStart
        {
            return
        }
        
        if delay < 10
        {
            delay++
            return
        }
        
        if isGameOver
        {
            return
        }
        
        isGameStarted = true
        var diff = currentTime - start
        start = currentTime
    
        if countdown < 1
        {
            countdown += diff
            return
        }
        timeCount++
        updateTime(String(timeCount))
        
        countdown = 0.0
    }
    
    func updateTime(time:String)
    {
        scroeLabel.text = time + " Sec"
    }
    
    func reInit()
    {
        isClickStart = false
        isGameStarted = false
        isGameOver = true
    }
    
    func drawNode(dx:Float, dy:Float, xi:Int, yi:Int)->Brick
    {
        var brick = Brick(w: self.frame.width / 4, h: self.frame.height / 4, xIndex:xi, yIndex:yi)
        brick.name = "brick" + String(yi)
        brick.position = CGPointMake(dx, dy)
        brickCnt.addChild(brick)
        
        return brick
    }
    
    func drawGrid()
    {
        var _data = Data.getData()
        
        let w:Float = self.frame.width * 0.25
        let h:Float = self.frame.height * 0.25
        
        for i in 0..(4 * 50)
        {
            var b = drawNode(Float(i % 4) * w + w / 2.0, dy: Float(Int(i / 4)) * h + h / 2.0,xi:i % 4, yi:Int(i / 4))
            var j = Int(i / 4)
            
            if (b.xIndex == _data[j].index_x && b.yIndex == _data[j].index_y)
            {
                b.setState(2)
            }
         
        }
    }
    
    func startGame(touch:AnyObject)
    {
        let location = touch.locationInNode(self)
        let node = self.nodeAtPoint(location)
        let nodeName:String? = "btStart"
        
        if (node.name == nodeName)
        {
            if !isClickStart
            {
                isClickStart = true
               
                let f = SKAction.fadeOutWithDuration(0.5)
                let r = SKAction.removeFromParent()
                
                fadeOut = SKAction.sequence([f, r])
                node.runAction(fadeOut)
                
                drawGrid()
            }
            
        }

    }
    
    func playGame(touch:AnyObject)
    {
        if !isGameStarted
        {
            return
        }
        
        let h:Float = self.frame.height * 0.25
        
        let location = touch.locationInNode(self)
        
        var node:Brick? = self.nodeAtPoint(location) as? Brick
        if node?.curState == 2
        {
            let f = SKAction.moveBy(CGVector(0, -h), duration:0.2)
            brickCnt.runAction(f)
        }
        
        if node?
        {
            var indexStr:String = (node?.name.substringFromIndex(5))!
            if preNodeIndex == -1
            {
                if indexStr.toInt() != 0
                {
                    gameOver()
                }
                else
                {
                    preNodeIndex = indexStr.toInt()!
                }
                
            }
            else
            {
                if node?.curState != 2
                {
                    gameOver()
                    return
                }
                
                if (indexStr.toInt()! - preNodeIndex) != 1
                {
                    gameOver()
                }
                else
                {
                    preNodeIndex = indexStr.toInt()!
                }
                
                if preNodeIndex == 49
                {
                    gameOver()
                }
            }
            
        }
        
    }
    
    func gameOver()
    {
        brickCnt.removeFromParent()
        reInit()
        
        myLabel.alpha = 100
        self.addChild(myLabel)
        
        if preNodeIndex == 49
        {
            myLabel.text = "your achievement : " + scroeLabel.text
            self.backgroundColor = UIColor.greenColor()
        }
        else
        {
            myLabel.text = "you fail.."
            self.backgroundColor = UIColor.redColor()
        }
    }

  
  
}
