import Foundation
import SpriteKit

public class GameWinScene: SKScene{
    
    let background = SKSpriteNode(imageNamed: "End Screen")
    let rocket = SKSpriteNode(imageNamed: "Foguete")
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        let judy = Judy.shared()
        judy.position = CGPoint(x: 225, y: 100)
        judy.setScale(0.1)
        
//        let backgroundSound = SKAudioNode(fileNamed: "AmbientMusic.mp3")
//        self.addChild(backgroundSound)
//        backgroundSound.run(SKAction.play())
        
        self.rocket.position = CGPoint(x: 250, y: 140)
        self.rocket.setScale(0.5)
        self.rocket.anchorPoint = CGPoint(x: 0, y: 0)
        
        let rocketAction = SKAction.move(to: CGPoint(x: 330, y: 1000), duration: 7)
        
        let animation = SKAction.animate(with: judy.rightTextures, timePerFrame: 0.125, resize: false, restore: true)
        judy.run(SKAction.repeatForever(animation), withKey: "walking")
        
        let emitter = SKEmitterNode(fileNamed: "MyParticle")
        emitter?.position = CGPoint(x: 170, y: 55)
        emitter?.zPosition = 0
        
        rocket.zPosition = 2

        
        judy.run(SKAction.move(to: CGPoint(x: 330, y: 200), duration: 5), completion: {
            judy.removeAction(forKey: "walking")
            judy.removeFromParent()
            self.rocket.addChild(emitter!)
            self.rocket.run(rocketAction, completion:  {
                self.rocket.removeFromParent()
                self.background.texture = SKTexture(imageNamed: "End Screen2")
            })
        })


        self.setupBackground()
        self.addChild(background)
        self.addChild(judy)
        self.addChild(rocket)
    }
    
    
    func setupBackground() {
        background.scale(to: CGSize(width: 650, height: 900))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
    }
}
