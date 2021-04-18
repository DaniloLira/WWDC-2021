import SpriteKit

public class ET: SKSpriteNode {
    var tilePosition: (Int, Int) = (0, 0)
    var question: Question
    var etColor: ETColor
    
    init(color: ETColor, x: Int, y: Int) {
        var texture = SKTexture(imageNamed: "ET Amarelo.png")
        
        switch color {
        case .yellow:
            texture = SKTexture(imageNamed: "ET Amarelo.png")
        case .green:
            texture = SKTexture(imageNamed: "ET Verde.png")
        case .purple:
            texture = SKTexture(imageNamed: "ET Roxo.png")
        }
        
        self.etColor = color
        self.question = Questions.shared().getRandomQuestion(color: color)
        super.init(texture: texture, color: .black, size: texture.size())
        self.isUserInteractionEnabled = true
        self.tilePosition = (x, y)
        self.setupStyle()

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
        let judyX = Judy.shared().tilePosition.0
        let judyY = Judy.shared().tilePosition.1
        
        if judyX + 1 == self.tilePosition.0 || judyX - 1 == self.tilePosition.0 {
            if judyY == self.tilePosition.1 {
                Popup.shared().open(question: self.question, et: self)
            }
        }
        
        if judyY + 1 == self.tilePosition.1 || judyY - 1 == self.tilePosition.1 {
            if judyX == self.tilePosition.0 {
                Popup.shared().open(question: self.question, et: self)
            }
        }
        
    }
    
    func setupStyle() {
        self.position = CGPoint(x: tilePosition.0 * 60, y: tilePosition.1 * 60)
        self.anchorPoint = CGPoint(x: 0.3, y: 0.1)
        self.setScale(0.11)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


enum ETColor {
    case yellow
    case green
    case purple
}
