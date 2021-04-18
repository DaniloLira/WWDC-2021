import SpriteKit

class Graybackground: SKSpriteNode {
    private static var privateShared : Graybackground?

    class func shared() -> Graybackground {
        guard let uwShared = privateShared else {
            privateShared = Graybackground()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy(){
        self.privateShared = nil
    }
    
    init() {
        let texture = SKTexture(imageNamed: "GrayBackground.png")
        super.init(texture: texture, color: .black, size: texture.size())
        self.scale(to: CGSize(width: 650, height: 900))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.isHidden = true
        self.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        JudysBook.shared().isHidden = true
        self.isHidden = true
    }
}
