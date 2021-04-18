
import SpriteKit

public class Discover: SKSpriteNode {
    var text: String
    var cardColor: ETColor
    var textLabel = SKLabelNode()
    
    init(cardColor: ETColor, text: String) {
        self.text = text
        self.cardColor = cardColor
        let texture: SKTexture
        
        switch cardColor {
        case .green:  texture = SKTexture(imageNamed: "postits/verde.png")
        case .yellow: texture = SKTexture(imageNamed: "postits/amarelo.png")
        case .purple: texture = SKTexture(imageNamed: "postits/roxo.png")
        }
        
        super.init(texture: texture, color: .black, size: texture.size())
        self.addChild(textLabel)
        self.setupText()
        self.setupStyles()
    }

    func setupText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "Kalam", size: 65)
        
        let textString = NSMutableAttributedString(string: self.text, attributes: [NSMutableAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 70, weight: .bold), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), NSMutableAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.textLabel.attributedText = textString
        
        textLabel.text = self.text
        textLabel.fontColor = .black
        textLabel.preferredMaxLayoutWidth = 800
        textLabel.numberOfLines = 7
        textLabel.position = CGPoint(x: 445, y: 230)
    }
    func setupStyles() {
        self.setScale(0.5) //scale(to: CGSize(width: 228, height: 217))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

