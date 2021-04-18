
import SpriteKit

public final class Popup: SKSpriteNode {
    private static var privateShared : Popup?

    class func shared() -> Popup{
        guard let uwShared = privateShared else {
            privateShared = Popup()
            return privateShared!
        }
        return uwShared
    }

    class func destroy() {
        privateShared = nil
    }
    
    
    
    var ball = SKSpriteNode(imageNamed: "Ball.png")
    var etHead = SKSpriteNode(imageNamed: "green_head")
    var title = SKLabelNode()
    var try_again_button = SKButtonNode()
    var alternative_one = SKButtonNode()
    var alternative_two = SKButtonNode()
    var alternative_three = SKButtonNode()
    var next_button = SKButtonNode()
    var question: Question? = nil
    var et: ET? = nil
    
    var state: PopupState = .question {
        didSet {
            switch state {
            case .question:
                if let definedQuestion = question {
                    self.alternative_one.label!.text = definedQuestion.alternative_one
                    self.alternative_two.label!.text = definedQuestion.alternative_two
                    self.alternative_three.label!.text = definedQuestion.alternative_three
                    self.setTitleText(definedQuestion.questionText)
                    self.next_button.isHidden = true
                    self.showAlternatives(true)
                    self.title.position = CGPoint(x: self.frame.midX + 300, y: 1025)
                    self.etHead.texture = SKTexture(imageNamed: "\(self.et!.etColor)_head")
                }
                
            case .correct:
                JudysBook.shared().addDiscover(etColor: et!.etColor, text: question!.answeredRightText)
                self.setTitleText(question!.answeredRightText)
                self.showAlternatives(false)
                self.next_button.isHidden = false
                self.title.position = CGPoint(x: self.frame.midX + 300, y: 900)
                GameScene.shared().run(SKAction.playSoundFileNamed("rightAnswer.wav", waitForCompletion: false))
                
            case .wrong:
                self.setTitleText("I'm sorry Judy, i think you are not ready yet, consider other alterantives for the next time. It was a nice try!")
                self.next_button.isHidden = true
                self.try_again_button.isHidden = false
                self.showAlternatives(false)
                self.title.position = CGPoint(x: self.frame.midX + 300, y: 900)
                GameScene.shared().run(SKAction.playSoundFileNamed("wrongAnswer.wav", waitForCompletion: false))
            }
        }
    }

    
    private init() {
        var texture = SKTexture(imageNamed: "Popup.png")
        super.init(texture: texture, color: .black, size: texture.size())
        self.setupStyle()
        self.setupText()
        self.setupButtons()
        self.setupBall()
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "OpenSans", size: 24)
        
        let textString = NSMutableAttributedString(string: text, attributes: [NSMutableAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 40, weight: .bold), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSMutableAttributedString.Key.paragraphStyle: paragraphStyle])
        
        
        self.title.attributedText = textString
    }
    
    func guess(option: Answer) {
        if let quest = question {
            self.state =  quest.guess(answer: option) ? .correct : .wrong
        }
    }
    
    func open(question: Question, et: ET) {
        self.et = et
        self.question = question
        self.state = .question
        self.isHidden = false
    }
    
    func showAlternatives(_ state: Bool) {
        self.alternative_one.isHidden = !state
        self.alternative_two.isHidden = !state
        self.alternative_three.isHidden = !state
    }
    
    func setupBall() {
        self.ball.position = CGPoint(x: 650, y: 1300)
        self.ball.setScale(0.8)
        self.etHead.position = CGPoint(x: 650, y: 1300)
        self.etHead.setScale(0.7)
        
        self.addChild(ball)
        self.addChild(etHead)
    }
    
    func setupStyle() {
        self.setScale(0.5)
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.zPosition = 2
    }
    
    func setupButtons() {
        let x = 630
        let y = 700
        let deltaY = 120
        
        let buttonTextureOne = SKSpriteNode(imageNamed: "Anotar.png")
        let buttonTextureTwo = SKSpriteNode(imageNamed: "Anotar.png")
        let buttonTextureThree = SKSpriteNode(imageNamed: "Anotar.png")
        
        self.alternative_one = SKButtonNode(image: buttonTextureOne, label: .init(text: "")) { [self] in self.guess(option: .alternative_one)}
        self.alternative_two = SKButtonNode(image: buttonTextureTwo, label: .init(text: "")) { [self] in self.guess(option: .alternative_two)}
        self.alternative_three = SKButtonNode(image: buttonTextureThree, label: .init(text: "")) { [self] in self.guess(option: .alternative_three)}
        
        self.next_button = SKButtonNode(image: SKSpriteNode(imageNamed: "Anotar.png"), label: .init(text: "Take note")) { [self] in
            self.isHidden = true
            JudysBook.shared().openBook()
            GameScene.shared().removeET(et: self.et!)
        }
        
        self.try_again_button = SKButtonNode(image: SKSpriteNode(imageNamed: "Anotar.png"), label: .init(text: "Try Again")) { [self] in
            GameScene.shared().backToStart()
        }
        
        alternative_one.position = CGPoint(x: x, y: y)
        alternative_two.position = CGPoint(x: x, y: (y + deltaY))
        alternative_three.position = CGPoint(x: x, y: (y + 2 * deltaY))
        next_button.position = CGPoint(x: x, y: (y + deltaY))
        try_again_button.position = CGPoint(x: x, y: (y + deltaY))
        try_again_button.isHidden = true
        
        self.addChild(alternative_one)
        self.addChild(alternative_two)
        self.addChild(alternative_three)
        self.addChild(next_button)
        self.addChild(try_again_button)
    }
    
    func setupText() {
        self.title.numberOfLines = 3
        self.title.preferredMaxLayoutWidth = 900
        self.title.position = CGPoint(x: self.frame.midX + 300, y: 1050)
        self.addChild(title)
    }
}

enum PopupState {
    case question
    case correct
    case wrong
}
