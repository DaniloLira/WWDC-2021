import SpriteKit

public class SKButtonNode : SKNode{
    
    var image: SKSpriteNode?
    var label: SKLabelNode?
    var action: (() -> Void)?
    
    override init() {
        super.init()
    }
    
    public init(image: SKSpriteNode, label optLabel: SKLabelNode? = nil, action: @escaping (()->Void) ){
        self.image = image
        self.action = action
        
        super.init()
        self.isUserInteractionEnabled = true
        
        self.addChild(image)
        
        if let label = optLabel {
            label.fontName = "OpenSans"
            label.fontColor = .white
            label.fontSize = 50
            label.verticalAlignmentMode = .center
            self.label = label
            self.addChild(label)
        }
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        GameScene.shared().run(SKAction.playSoundFileNamed("clickSound.wav", waitForCompletion: false))
        self.action?()
    }
    
}
