import Foundation
import SpriteKit

public class StartScene: SKScene{
    
    let background = SKSpriteNode(imageNamed: "Start screen")
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
//        let backgroundSound = SKAudioNode(fileNamed: "AmbientMusic.mp3")
//        self.addChild(backgroundSound)
//        backgroundSound.run(SKAction.play())
        
        let button = SKButtonNode(image: .init(imageNamed: "Anotar.png"), label: .init(text: "START"), action: {
            GameScene.destroy()
            let sceneMoveTo = GameScene.shared()
            sceneMoveTo.scaleMode = self.scaleMode
            let transition = SKTransition.moveIn(with: .down, duration: 0.3)
            view.presentScene(sceneMoveTo ,transition: transition)
        })
        
        button.setScale(0.6)
        button.position = CGPoint(x: 325, y: 420)
        self.setupBackground()
        self.addChild(background)
        self.addChild(button)
    }
    
    
    func setupBackground() {
        background.scale(to: CGSize(width: 650, height: 900))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
    }
}
