import SpriteKit

public class Rocket: SKSpriteNode {

    
    init() {
        var texture = SKTexture(imageNamed: "Foguete")
        super.init(texture: texture, color: .black, size: texture.size())
        self.isUserInteractionEnabled = true
        self.position = CGPoint(x: 7.8 * 60, y: 10.5 * 60)
        self.setScale(0.5)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        GameScene.shared().addChild(self)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        if Judy.shared().tilePosition.0 == 8 && Judy.shared().tilePosition.1 == 11 {
            GameScene.shared().winGame()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
